# frozen_string_literal: true

module Engine
  class Bing < BaseEngine
    BING_SEARCH_URL = 'https://www.bing.com/search'

    private

    def base_url
      BING_SEARCH_URL
    end
  end
end
