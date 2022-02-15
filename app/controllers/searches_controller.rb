# frozen_string_literal: true

class SearchesController < ApplicationController
  # GET /search?text=query_terms&engine[]=google&engine[]=bing
  def index
    results = requested_engines.map do |engine|
      engine_class = "Engine::#{engine.classify}".constantize
      engine_class.new(search_params.fetch(:text)).find_search_results
    end.flatten

    render json: { results: }
  end

  private

  def search_params
    params.permit(:text, engine: []).to_h
  end

  def requested_engines
    search_params.fetch(:engine).reduce([]) do |engines, engine|
      unless Engine::SUPPORTED_ENGINES.include?(engine)
        raise Errors::UnsupportedEngineError,
              "Unsupported engine: #{engine}"
      end

      engines + [engine]
    end.uniq
  end
end
