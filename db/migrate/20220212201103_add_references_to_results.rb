# frozen_string_literal: true

class AddReferencesToResults < ActiveRecord::Migration[7.0]
  disable_ddl_transaction!

  def change
    add_reference :results, :search, index: { algorithm: :concurrently }, null: false
  end
end
