# frozen_string_literal: true

class EditColumnRememberTockenInUsers < ActiveRecord::Migration[7.0]
  def change
    reversible do |dir|
      change_table :users, bulk: true do |t|
        dir.up do
          t.column :remember_token_digest, :string
        end
        dir.down do
          t.remove :remember_token, :string
        end
      end
    end
  end
end
