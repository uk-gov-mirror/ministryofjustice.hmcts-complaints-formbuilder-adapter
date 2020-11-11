desc 'Retrieves submission IDs for all Delayed::Jobs in the queue'
task list_failed_submission_ids: :environment do
  submission_ids = Delayed::Job.all.map do |job|
    job.handler.match(/(?<=submissionId: )(.*)(?=\n)/)[0]
  end

  if submission_ids.empty?
    puts 'No submission IDs found'
  else
    puts submission_ids
  end
end
