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
require 'rails_helper'

RSpec.describe Result, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
