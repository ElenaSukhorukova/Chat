# frozen_string_literal: true

class AddRememberTokenDigestToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :remember_token, :string
  end
end
