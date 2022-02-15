# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Searches', type: :request do
  describe 'GET /search' do
    let!(:query_terms) { Faker::Lorem.sentence }

    let!(:google_results) do
      Array.new(rand(1..3)) do
        {
          title: Faker::Lorem.sentence,
          url: Faker::Internet.url,
          description: Faker::Lorem.sentence
        }
      end
    end

    let!(:bing_results) do
      Array.new(rand(1..3)) do
        {
          title: Faker::Lorem.sentence,
          url: Faker::Internet.url,
          description: Faker::Lorem.sentence
        }
      end
    end

    before do
      allow_any_instance_of(Engine::Google).to receive(:find_search_results).and_return(google_results)
      allow_any_instance_of(Engine::Bing).to receive(:find_search_results).and_return(bing_results)
    end

    context 'when retrieving google results,' do
      subject { get searches_path, params: { engine: ['google'], text: query_terms } }

      before { subject }

      it 'returns the google results' do
        expect(response).to have_http_status(:ok)
        google_results.each do |result|
          expect(response.body).to include(result.fetch(:title))
          expect(response.body).to include(result.fetch(:description))
          expect(response.body).to include(result.fetch(:title))
        end
      end

      it 'does not return bing results' do
        bing_results.each do |result|
          expect(response.body).not_to include(result.fetch(:title))
          expect(response.body).not_to include(result.fetch(:description))
          expect(response.body).not_to include(result.fetch(:title))
        end
      end
    end

    context 'when retrieving bing results,' do
      subject { get searches_path, params: { engine: ['bing'], text: query_terms } }

      before { subject }

      it 'returns the bing results' do
        expect(response).to have_http_status(:ok)
        bing_results.each do |result|
          expect(response.body).to include(result.fetch(:title))
          expect(response.body).to include(result.fetch(:description))
          expect(response.body).to include(result.fetch(:title))
        end
      end

      it 'does not return google results' do
        google_results.each do |result|
          expect(response.body).not_to include(result.fetch(:title))
          expect(response.body).not_to include(result.fetch(:description))
          expect(response.body).not_to include(result.fetch(:title))
        end
      end
    end

    context 'when retrieving both results,' do
      subject { get searches_path, params: { engine: %w[bing google], text: query_terms } }

      before { subject }

      it 'returns the google results' do
        expect(response).to have_http_status(:ok)
        google_results.each do |result|
          expect(response.body).to include(result.fetch(:title))
          expect(response.body).to include(result.fetch(:description))
          expect(response.body).to include(result.fetch(:title))
        end
      end

      it 'returns the bing results' do
        expect(response).to have_http_status(:ok)
        bing_results.each do |result|
          expect(response.body).to include(result.fetch(:title))
          expect(response.body).to include(result.fetch(:description))
          expect(response.body).to include(result.fetch(:title))
        end
      end
    end

    context 'when requesting an unsupported engine,' do
      subject { get searches_path, params: { engine: ['foo'], text: query_terms } }

      before { subject }

      it 'returns a 400' do
        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end
