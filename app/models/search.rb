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
class Search < ApplicationRecord
  has_many :results, dependent: :destroy
end
