class YoutubeSearch::UseCases::YoutubeData

  # This function file is used to fetch the youtube data
  # @param per_page_count[Integer] - count of elements in a page
  # @param page_no[Integer] - page no
  # @return List<YoutubeSearch::Models::YoutubeData>
  def fetch(per_page_count:, page_no:)
    offset = per_page_count * (page_no - 1)
    limit = per_page_count

    return youtube_data_repo.fetch(offset: offset, limit: limit)
  end

  # This function returns the count of youtube data in db
  # @return []Integer]
  def count
    return youtube_data_repo.count
  end

  private

  def youtube_data_repo
    return YoutubeSearch::Repos::YoutubeData.new
  end
end