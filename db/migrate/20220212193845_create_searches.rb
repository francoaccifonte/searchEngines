# frozen_string_literal: true

class CreateSearches < ActiveRecord::Migration[7.0]
  def change
    create_table :searches do |t|
      t.string :query_terms, array: true, default: []
      t.string :engine
      t.string :type

      t.timestamps
    end
  end
end
