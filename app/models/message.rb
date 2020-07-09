class Message < ApplicationRecord
  belongs_to :channel
  belongs_to :user

  after_create :process_mentions

  def process_mentions
    UnreadsChannel.broadcast_to channel, { mentions: mentioned_usernames, body: body }
  end

  def mentioned_users
    User.where(username: mentioned_usernames) - [user]
  end

  def mentioned_usernames
    body.scan(/@([\w-]+)/).flatten
  end
end
