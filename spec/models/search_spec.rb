# frozen_string_literal: true

# == Schema Information
#
# Table name: searches
#
#  id          :bigint           not null, primary key
#  engine      :string
#  query_terms :string           default([]), is an Array
#  type        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require 'rails_helper'

RSpec.describe Search, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
