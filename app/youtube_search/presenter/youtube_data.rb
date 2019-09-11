class YoutubeSearch::Presenter::YoutubeData

  def present(youtube_data:)
    return {
        query: YoutubeSearch::UseCases::YoutubeMiner::QUERY,
        youtube_data: youtube_data.map do |data|
          {
              video_id: data[:video_id],
              title: data[:title],
              description: data[:description],
              thumbnail_url: data[:thumbnail_url],
              published_at: Time.at(data[:published_at])
          }
        end
    }
  end
end
