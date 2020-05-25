class ChannelUsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_channel

  def create
    @channel.channel_users.where(user: current_user).first_or_create
    redirect_to @channel
  end

  def destroy
    @channel.channel_users.where(user: current_user).destroy_all
    redirect_to @channel
  end

  private

    def set_channel
      @channel = Channel.find(params[:channel_id])
    end
end
