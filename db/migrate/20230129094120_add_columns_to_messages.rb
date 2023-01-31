# frozen_string_literal: true

class AddColumnsToMessages < ActiveRecord::Migration[7.0]
  def change
    add_reference :messages, :chatroom, null: false, foreign_key: true, default: 1
  end
end
