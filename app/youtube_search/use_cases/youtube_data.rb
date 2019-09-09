class YoutubeSearch::UseCases::YoutubeData

  def fetch(per_page_count:, page_no:)
    offset = per_page_count * (page_no - 1)
    limit = per_page_count

    return youtube_data_repo.fetch(offset: offset, limit: limit)
  end

  private

  def youtube_data_repo
    return YoutubeSearch::Repos::YoutubeData.new
  end
end