class YoutubeSearch::Repos::YoutubeData

  # This is used to save the youtube data in db
  # @param youtube_data[Array<YoutubeSearch::Models::YoutubeData>] -  the array of the youtube data
  # @return nil
  def save(youtube_data:)
    youtube_data.each do|data|
      data.save!
    end

    return nil
  end

  # This function used to fetch the data from the db
  # @param offset[Integer] - the offset value
  # @param limit[Integer] - the limit value
  # @return List<YoutubeSearch::Models::YoutubeData>
  def fetch(offset:, limit:)
    YoutubeSearch::Models::YoutubeData
        .limit(limit)
        .offset(offset)
        .order('published_at desc').to_a
  end

  # This function counts total no of entries in db
  # @return count[Integer]
  def count
    return YoutubeSearch::Models::YoutubeData.count
  end
end