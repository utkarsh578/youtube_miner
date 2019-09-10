class Api::V1::Youtube::Data::YoutubeController < ApplicationController
  skip_before_action :verify_authenticity_token

  def fetch
    valid_params = %w(per_page_count page_no)
    return unless check_params_presence?(params: params, valid_params: valid_params)

    per_page_count = params[:per_page_count]
    page_no = params[:page_no]

    youtube_data = YoutubeSearch::UseCases::YoutubeData
                       .new
                       .fetch(per_page_count: per_page_count.to_i, page_no: page_no.to_i)

    presented_youtube_data = YoutubeSearch::Presenter::YoutubeData.new.present(youtube_data: youtube_data)

    render json: presented_youtube_data, status: 200
  end

  #This is only to verify if Job server is adding the new content in DB or not
  def count
    count = YoutubeSearch::UseCases::YoutubeData
        .new
        .count

    render json: {count: count}, status: 200
  end
end