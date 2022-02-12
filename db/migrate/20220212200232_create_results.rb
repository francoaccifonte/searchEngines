# frozen_string_literal: true

class CreateResults < ActiveRecord::Migration[7.0]
  def change
    create_table :results do |t|
      t.string :url
      t.string :title
      t.string :description

      t.timestamps
    end
  end
end
