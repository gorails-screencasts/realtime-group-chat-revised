class MessageChannel < ApplicationCable::Channel
  def subscribed
    stop_all_streams
    stream_for Channel.find(params["id"])
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    stop_all_streams
  end
end
