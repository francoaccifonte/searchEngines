# frozen_string_literal: true

module Engine
  # This class implements the base functionality for all engines.
  # To implement a new engine add it to the list, and implement the following methods:
  # - base_url
  # - parse_results // optional
  # - parse_query // optional

  class BaseEngine
    include HttpRequests

    attr_accessor :query
    attr_reader :search_results

    def initialize(query)
      @query = query
    end

    def find_search_results
      @search_results = parse_results(get(base_url, query_params: parsed_query))
    end

    private

    def parsed_query
      @query.gsub(/\s/, '+')
    end

    def base_url
      raise NotImplementedError, "base_url method not implemented for #{self.class}"
    end

    def parse_results(response)
      # if the response from the search engine needs to be processed, implement this method
      # return valuew should be an array of hashes like the following:
      # [{ title: 'title', url: 'link', description: 'description' }]
      response.force_encoding('ISO-8859-1').encode('UTF-8')
    end

    def handle_error(response)
      return if response.success?

      raise StandardError, "Error: #{response.code} #{response.body}"
    end

    def http_options(**params)
      super(**params).merge(followlocation: true)
    end
  end
end
