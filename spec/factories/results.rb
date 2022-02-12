# frozen_string_literal: true

# == Schema Information
#
# Table name: results
#
#  id          :bigint           not null, primary key
#  description :string
#  title       :string
#  url         :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  search_id   :bigint           not null
#
# Indexes
#
#  index_results_on_search_id  (search_id)
#
# Foreign Keys
#
#  fk_rails_...  (search_id => searches.id) ON DELETE => cascade
#
FactoryBot.define do
  factory :result do
  end
end
