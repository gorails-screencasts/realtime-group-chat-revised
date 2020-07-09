module ChannelsHelper
  def active_channel?(channel)
    channel == @channel
  end
end
