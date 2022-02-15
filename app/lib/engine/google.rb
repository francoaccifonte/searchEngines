# frozen_string_literal: true

module Engine
  class Google < BaseEngine
    GOOGLE_SEARCH_URL = 'https://www.google.com/search'

    private

    def base_url
      GOOGLE_SEARCH_URL
    end
  end
end
