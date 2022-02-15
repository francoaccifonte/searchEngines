# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from Errors::ControllerError, with: :generic_error
  rescue_from Errors::UnsupportedEngineError, with: :unsupported_engine_error

  def unsupported_engine_error(error)
    render json: { message: 'received an unsupported search engine', error: error.message }, status: :bad_request
  end

  def generic_error(error)
    render json: { error: error.message }, status: error.status || :internal_server_error
  end
end
