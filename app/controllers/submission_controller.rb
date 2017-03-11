class SubmissionController < ApplicationController
  include Response

  def verify_submission
    pcode = params[:pcode]
    user_source_code = params[:user_source_code]
    problem = Problem.by_pcode(pcode).first
    json_response({ error: 'wrong problem code' }, 500) && return if problem.nil?
    submission = Submission.new(user_source_code: user_source_code)
    problem.submissions << submission
    submission.save!
    ProcessSubmissionWorker.perform_async(submission_id: submission[:id].to_s)
    redirect_to(get_submission_path(submission[:id])) && return
  end

  def get_submission
    submission = Submission.by_id(params['submission_id']).first
    msg = if submission.nil?
            { error: 'bad submission' }
          else
            { id: submission[:id].to_s, status_code: submission[:status_code], error_desc: submission[:error_desc] }
          end
    json_response(msg)
  end
end
