# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Searches', type: :request do
  describe 'GET /search' do
    let!(:query_terms) { Array.new(rand(1..3)) { Faker::Lorem.unique.word } }
    let!(:unrelated_query_terms) { Array.new(rand(1..3)) { Faker::Lorem.unique.word } }

    let!(:google_search) { create(:search, :google, query_terms:) }
    let!(:google_results) { create_list(:result, rand(1..3), search: google_search) }
    let!(:unrelated_google_search) { create(:search, :google, query_terms: unrelated_query_terms) }
    let!(:unrelated_google_results) { create_list(:result, rand(1..3), search: unrelated_google_search) }

    let!(:bing_search) { create(:search, :bing, query_terms:) }
    let!(:bing_results) { create_list(:result, rand(1..3), search: bing_search) }
    let!(:unrelated_bing_search) { create(:search, :bing, query_terms: unrelated_query_terms) }
    let!(:unrelated_bing_results) { create_list(:result, rand(1..3), search: unrelated_bing_search) }

    shared_examples_for 'does not return unrelated results' do
      it 'does not return unrelated results' do
        (unrelated_google_results + unrelated_bing_results).each do |result|
          expect(response.body).not_to include(result.title)
          expect(response.body).not_to include(result.description)
          expect(response.body).not_to include(result.title)
        end
      end
    end

    context 'when retrieving google results,' do
      subject { get searches_path, params: { engine: 'google', text: google_search.query_terms } }

      before { subject }

      it_behaves_like 'does not return unrelated results'

      it 'returns the google results' do
        expect(response).to have_http_status(:ok)
        google_results.each do |result|
          expect(response.body).to include(result.title)
          expect(response.body).to include(result.description)
          expect(response.body).to include(result.title)
        end
      end

      it 'does not return bing results' do
        bing_results.each do |result|
          expect(response.body).not_to include(result.title)
          expect(response.body).not_to include(result.description)
          expect(response.body).not_to include(result.title)
        end
      end
    end

    context 'when retrieving bing results,' do
      subject { get searches_path, params: { engine: 'bing', text: bing_search.query_terms } }

      before { subject }

      it_behaves_like 'does not return unrelated results'

      it 'returns the bing results' do
        expect(response).to have_http_status(:ok)
        bing_results.each do |result|
          expect(response.body).to include(result.title)
          expect(response.body).to include(result.description)
          expect(response.body).to include(result.title)
        end
      end

      it 'does not return google results' do
        google_results.each do |result|
          expect(response.body).not_to include(result.title)
          expect(response.body).not_to include(result.description)
          expect(response.body).not_to include(result.title)
        end
      end
    end

    context 'when retrieving both results,' do
      subject { get searches_path, params: { engine: %w[bing google], text: bing_search.query_terms } }

      before { subject }

      it_behaves_like 'does not return unrelated results'

      it 'returns the google results' do
        expect(response).to have_http_status(:ok)
        google_results.each do |result|
          expect(response.body).to include(result.title)
          expect(response.body).to include(result.description)
          expect(response.body).to include(result.title)
        end
      end

      it 'returns the bing results' do
        expect(response).to have_http_status(:ok)
        bing_results.each do |result|
          expect(response.body).to include(result.title)
          expect(response.body).to include(result.description)
          expect(response.body).to include(result.title)
        end
      end
    end
  end
end
