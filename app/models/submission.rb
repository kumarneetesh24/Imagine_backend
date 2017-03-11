class Submission < ApplicationRecord
  belongs_to :problem, counter_cache: true

  def create_submission_data
    problem = self.problem
    system 'mkdir', '-p', "#{CONFIG[:base_path]}/submit/#{problem[:pcode]}/#{self[:_id]}"
    user_source_code = File.open("#{CONFIG[:base_path]}/submit/#{problem[:pcode]}/#{self[:_id]}/user_source_code.c", 'w')
    user_source_code.write(self[:user_source_code])
    user_source_code.close
    problem.test_cases.each do |test_case|
      system 'mkdir', '-p', "#{CONFIG[:base_path]}/submit/#{problem[:pcode]}/#{self[:_id]}/#{test_case[:name]}"
    end
    true
  end

  def delete_submission_data
    problem = self.problem
    system 'rm', '-rf', "#{CONFIG[:base_path]}/submit/#{problem[:pcode]}/#{self[:_id]}"
    true
  end
end
