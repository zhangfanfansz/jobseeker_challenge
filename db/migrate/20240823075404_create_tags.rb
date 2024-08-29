# frozen_string_literal: true

class CreateTags < ActiveRecord::Migration[7.0]
  def change
    create_table :tags do |t|
      t.string :tag_name
      t.string :tag_code_name

      t.timestamps
    end
    add_index :tags, :tag_code_name, unique: true
  end
end
