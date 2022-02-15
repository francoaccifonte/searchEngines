# frozen_string_literal: true

class SearchesController < ApplicationController
  # GET /search?text=query_terms&engine[]=google&engine[]=bing
  def index
    requested_engines.map do |engine|
      engine_class = "Engine::#{engine.classify}".constantize
      engine_class.new(search_params.fetch(:text)).find_search_results
    end.flatten
  end

  private

  def search_params
    params.permit(:text, engine: []).to_h
  end

  def requested_engines
    search_params.fetch(:engine).reduce([]) do |engines, engine|
      engines + [engine] if ENGINE::SUPPORTED_ENGINES.include?(engine)
    end.uniq
  end
end
