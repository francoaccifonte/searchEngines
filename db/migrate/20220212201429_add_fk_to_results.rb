# frozen_string_literal: true

class AddFkToResults < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :results, :searches, column: :search_id, on_delete: :cascade, validate: false
  end
end
