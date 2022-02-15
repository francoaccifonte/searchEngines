# frozen_string_literal: true

module HttpRequests
  extend ActiveSupport::Concern

  SUPPORTED_METHODS = %i[get post put delete].freeze

  def get(url, query_params: nil, body: nil, headers: {})
    http_request(url, :get, query_params:, body:, headers:)
  end

  def post(url, query_params: nil, body: nil, headers: {})
    http_request(url, :post, query_params:, body:, headers:)
  end

  def put(url, query_params: nil, body: nil, headers: {})
    http_request(url, :put, query_params:, body:, headers:)
  end

  def delete(url, query_params: nil, body: nil, headers: {})
    http_request(url, :delete, query_params:, body:, headers:)
  end

  private

  def http_request(url, method, body: nil, headers: {}, query_params: nil) # rubocop:disable Metrics/MethodLength
    raise ArgumentError, 'url is required' if url.blank?
    raise ArgumentError, 'invalid method' unless SUPPORTED_METHODS.include?(method)

    request = Typhoeus::Request.new(
      url,
      method:,
      body:,
      params: query_params,
      headers: default_headers.merge(headers.deep_stringify_keys)
    )

    response = request.run

    handle_error(response)
    begin
      JSON.parse(response.body, symbolize_names: true)
    rescue JSON::ParserError
      response.body
    end
  end

  def default_headers
    base = {
      'Accept' => 'application/json',
      'Content-Type' => 'application/json'
    }
    base['Authorization'] = authorization_header if authorization_header.present?
    base
  end

  def handle_error(_response)
    raise NotImplementedError, "handle_error method not implemented for #{self.class}"
  end

  def authorization_header
    nil
  end
end
