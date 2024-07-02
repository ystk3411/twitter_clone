# frozen_string_literal: true

class MessagesController < ApplicationController
  before_action :authenticate_user!

  def index
    my_room_ids = current_user.entries.pluck(:room_id)
    @another_entries = Entry.where(room_id: my_room_ids).where.not(user_id: current_user.id)
  end

  def create
    if Entry.where(user_id: current_user.id, room_id: params[:id]).present?
      @message = Message.create!(user_id: current_user.id, room_id: params[:id], content: params[:content])
      redirect_to request.referer
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def show
    my_room_ids = current_user.entries.pluck(:room_id)

    @another_entries = Entry.where(room_id: my_room_ids).where.not(user_id: current_user.id)
    @room = Room.find(params[:id])

    if Entry.where(user_id: current_user.id, room_id: @room.id).present?
      @messages = @room.messages
      @message = Message.new
      @entries = @room.entries
      @another_entry = @entries.find_by('user_id != ?', current_user.id)
    else
      redirect_back(fallback_location: root_path)
    end
  end
end
