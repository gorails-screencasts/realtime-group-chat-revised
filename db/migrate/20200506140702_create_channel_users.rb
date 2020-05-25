class CreateChannelUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :channel_users do |t|
      t.belongs_to :channel, null: false, foreign_key: true
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
