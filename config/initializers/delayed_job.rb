# disable error logging to keep secrets out of the logs
Delayed::Backend::ActiveRecord::Job.logger.level = :fatal
