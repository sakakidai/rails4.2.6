class TestWorker
  include Sidekiq::Worker

  def perform(process_time = 10)
    Rails.logger.info('start TestWorker')
    Rails.logger.info("Please waiting at #{process_time}.")
    sleep(process_time)
    Rails.logger.info("time is #{Time.zone.now}")
    Rails.logger.info('end TestWorker')
  end
end
