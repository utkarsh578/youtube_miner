class Workers::YoutubeWorker
  include Sidekiq::Worker
  def perform
    Log.i "Fetching data from youtube at: #{Time.now}"
    YoutubeSearch::UseCases::YoutubeMiner.new.mine
  end
end
