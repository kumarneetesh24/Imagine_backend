class ProcessSubmissionWorker
  include Sidekiq::Worker
  sidekiq_options unique: :until_executed, queue: :default, retry: 5

  def perform(args)
    submission_id = args['submission_id']
    submission = Submission.by_id(submission_id).first
    return if submission.nil? || submission[:status_code] != 'PE'
    problem = submission.problem
    testcases = problem.test_cases
    tlim = 5
    submission_path = "#{CONFIG[:base_path]}/submit/#{problem[:pcode]}/#{submission_id}/"
    judge_path = "#{CONFIG[:base_path]}/judge_exec/judge_exec"
    problem_path = "#{CONFIG[:base_path]}/problems/#{problem[:pcode]}/"

    if !File.exist?(submission_path + "/user_source_code.cpp")
      submission.update!(status_code: 'CE', error_desc: "CANNOT COMPILE CONTACT ADMIN")
      system 'rm', '-rf', submission_path
      return
    end
    compilation = nil
    compilation = "bash -c 'g++ -std=c++0x -w -O2 -fomit-frame-pointer -lm -o compiled_code user_source_code.cpp &> compile_log'"

    if compilation.nil?
      submission.update!(status_code: 'CE', error_desc: "CANNOT COMPILE CONTACT ADMIN")
      return
    end


    pid = Process.spawn(compilation, chdir: submission_path)
    _, status = Process.wait2(pid)
    if !status.exited? || status.exitstatus != 0
      begin
        compile_log = File.read(submission_path + 'compile_log')
      rescue
        compile_log = 'compilation Error'
      end
      submission.update!(status_code: 'CE', error_desc: compile_log)
      return
    end

    time_taken = 0
    if testcases.count == 0
      submission.update!( status_code: 'WA', error_desc: 'WA')
      return
    end
    testcases.each_with_index do |testcase, index|
      if !File.exist?("#{problem_path}#{testcase[:name]}/testcase")
        submission.update!( status_code: 'WA', error_desc: 'WA')
        return
      end
      execution = nil
      execution = "bash -c 'sudo #{judge_path} --cpu #{tlim} --usage usage_log --exec compiled_code < #{problem_path}#{testcase[:name]}/testcase' > #{testcase[:name]}/testcase_output"

      pid = Process.spawn(execution, chdir: submission_path)
      _,status = Process.wait2(pid)
      judge_usage = File.read(submission_path+'usage_log')
      @judge_data = judge_usage.split("\n")
      time_taken += @judge_data[@judge_data.size-1].to_f

      if @judge_data[0] == 'AC'
        user_output = submission_path + "#{testcase[:name]}/testcase_output"
        code_output = problem_path + "#{testcase[:name]}/testcase_output"
        if !File.exist?(user_output) || !File.exist?(code_output)
          submission.update!( status_code: 'WA', error_desc: 'WA')
          return
        end
        diff = %x(diff -ZBb #{user_output} #{code_output})
        if diff.length > 0
          @judge_data[0] = 'WA'
          submission.update!( status_code: 'WA', error_desc: 'WA')
          return
        end
      elsif @judge_data[0] == 'RTE'
        submission.update!( status_code: @judge_data[0], error_desc: @judge_data[1])
        return
      else
        submission.update!( status_code: @judge_data[0])
        return
      end
    end
    submission.update!( status_code: @judge_data[0] )
    return
  end
end
