class YoutubeSearch::UseCases::YoutubeMiner

  QUERY = 'songs'
  TIME_DIFF = 5.minutes

  TYPE = 'video'
  ORDER_BY = 'date'

  #This class is responsible for mining the data from youtube
  # @return nil
  def mine
    current_datetime = Time.now.utc
    video_data = request_youtube.get_youtube_data(
        query: QUERY,
        published_after_date: current_datetime - 5.minutes,
        published_before_date: current_datetime,
        type: TYPE,
        order_by: ORDER_BY
    )

    youtube_data = construct_youtube_data(video_data: video_data)
    youtube_data_repo.save(youtube_data: youtube_data)

    return nil
  end

  private

  def youtube_data_repo
    return YoutubeSearch::Repos::YoutubeData.new
  end

  def request_youtube
    return YoutubeSearch::Helpers::RequestYoutube.new
  end

  def construct_youtube_data(video_data:)
    current_time = Time.now.to_i

    video_data['items'].map do|item|
      YoutubeSearch::Models::YoutubeData.new(
          video_id: item['id']['videoId'],
          title: item['snippet']['title'],
          description: item['snippet']['description'],
          thumbnail_url: item['snippet']['thumbnails']['default']['url'],
          published_at: DateTime.parse(item['snippet']['publishedAt']).to_i,
          fetched_at: current_time
      )
    end
  end
end