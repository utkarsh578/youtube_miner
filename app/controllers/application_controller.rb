class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def check_params_presence?(params:, valid_params:)
    error_message = "Please send valid params i.e #{valid_params.join(',')}"
    valid_params.each do|valid_param|
      if params[valid_param].nil?
        render json: {error_message: error_message}, status: 406
        return false
      end
    end
    return true
  end
end
