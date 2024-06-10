# frozen_string_literal: true

class MessagesController < ApplicationController
  before_action :authenticate_user!

  def index
    current_entries = current_user.entries
    my_room_ids = []

    current_entries.each do |entry|
      my_room_ids << entry.room.id
    end

    @another_entries = Entry.where(room_id: my_room_ids).where('user_id != ?', current_user.id)
  end

  def create
    if Entry.where(user_id: current_user.id, room_id: params[:id]).present?
      Rails.logger.debug 'test'
      Rails.logger.debug params
      @message = Message.create!(user_id: current_user.id, room_id: params[:id], content: params[:content])
      redirect_to request.referer
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def show
    current_entries = current_user.entries
    my_room_ids = []

    current_entries.each do |entry|
      my_room_ids << entry.room.id
    end

    @another_entries = Entry.where(room_id: my_room_ids).where('user_id != ?', current_user.id)
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
