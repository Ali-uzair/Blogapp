# frozen_string_literal: true

class AddContentToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :content, :text, { :null => false }
  end
end
