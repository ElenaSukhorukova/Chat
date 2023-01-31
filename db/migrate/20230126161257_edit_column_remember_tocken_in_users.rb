# frozen_string_literal: true

class EditColumnRememberTockenInUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column(:users, :remember_token, :string)
    add_column(:users, :remember_token_digest, :string)
  end
end
