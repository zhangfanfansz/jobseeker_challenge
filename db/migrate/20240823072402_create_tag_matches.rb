# frozen_string_literal: true

class CreateTagMatches < ActiveRecord::Migration[7.0]
  def change
    create_table :tag_matches do |t|
      t.string :taggable_name
      t.references :tag
      t.references :taggable, polymorphic: true, null: false
      t.timestamps
    end
    add_index :tag_matches, :taggable_id
  end
end
