class CreateChatrooms < ActiveRecord::Migration[7.0]
  def change
    create_table :chatrooms do |t|
      t.string :chatroom_name, null: false, index: { unique: true }
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
