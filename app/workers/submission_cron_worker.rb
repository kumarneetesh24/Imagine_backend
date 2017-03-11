class SubmissionCronWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  sidekiq_options failures: true

  recurrence { hourly.minute_of_hour(0, 15, 30, 45) }

  def perform
    submissions = Submission.where(status_code: 'PE')
    if submissions.nil?
      return
    end
    submissions.each do |submission|
      queue = Sidekiq::Queue.new('default')
      enqueue = true
      queue.each do |job|
        enqueue = false if job.args[0]['submission_id'] == submission.id
      end
      args = {
        submission_id: submission[:id].to_s
      }
      ProcessSubmissionWorker.perform_async(args) if enqueue
    end
  end
end
