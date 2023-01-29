class CreateChatroomUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :chatroom_users do |t|
      t.belongs_to :chatroom, null: false
      t.belongs_to :user, null: false

      t.timestamps
    end
  end
end
