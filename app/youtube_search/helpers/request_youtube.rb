require 'httparty'

class YoutubeSearch::Helpers::RequestYoutube
  PART = 'snippet'
  MAX_RESULT_COUNT = 50

  private_constant :PART
  private_constant :MAX_RESULT_COUNT

  # This function fetches the data from youtube
  # @param query[String] - The search query
  # @param published_after_date[Datetime] - The datetime after which the result needs to be fetched
  # @param published_before_date[Datetime] - The datetime before which the result needs to be fetched
  # @param type[String] - the type of content which we want to fetch
  # @param order_by[String] - the order by field
  # @return Hash - containing the youtube data
  # @raises StandardError
  def get_youtube_data(query:, published_after_date:, published_before_date:, type:, order_by:)
    return get_data(query: query,
                    published_after_date: published_after_date,
                    published_before_date: published_before_date,
                    type: type,
                    order_by: order_by)
  end

  private

  def get_data(query:, published_after_date:, published_before_date:, type:, order_by:)
    #Constructing the uri for GET HTTP request
    uri = get_uri(
        query: query,
        published_after_date: published_after_date,
        published_before_date: published_before_date,
        type: type,
        order_by: order_by
    )

    #Making HTTP GET call to youtube
    response = HTTParty.get(uri)
    json_response = JSON.parse(response.body)
    if json_response['error'].present?
      raise StandardError
                .new("Something bad happened, code - #{json_response['error']['code']} Message - #{json_response['error']['message']}")
    end

    return json_response
  end

  def get_uri(query:, published_after_date:, published_before_date:, type:, order_by:)
    return ENV['YOUTUBE_BASE_URL'] +
        "?order=#{order_by}" +
        "&part=#{PART}" +
        "&publishedAfter=#{published_after_date.strftime("%FT%TZ")}" +
        "&publishedBefore=#{published_before_date.strftime("%FT%TZ")}" +
        "&type=#{type}" +
        "&videoCaption=any" +
        "&q=#{query}" +
        "&key=#{ENV['YOUTUBE_API_KEY']}" +
        "&maxResults=#{MAX_RESULT_COUNT}"
  end
end