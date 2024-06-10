class MessagesController < ApplicationController
  before_action :authenticate_user!

  def index
    current_entries = current_user.entries
    myRoomIds = []

    current_entries.each do |entry|
      myRoomIds << entry.room.id
    end

    @anotherEntries = Entry.where(:room_id => myRoomIds).where('user_id != ?',current_user.id)
  end

  def create
    if Entry.where(:user_id => current_user.id, :room_id => params[:id]).present?
      p "test"
      p params
      @message = Message.create!(:user_id => current_user.id, :room_id => params[:id], :content => params[:content])
      redirect_to request.referer
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def show
    current_entries = current_user.entries
    myRoomIds = []

    current_entries.each do |entry|
      myRoomIds << entry.room.id
    end

    @anotherEntries = Entry.where(:room_id => myRoomIds).where('user_id != ?',current_user.id)
    @room = Room.find(params[:id])

    if Entry.where(:user_id => current_user.id, :room_id => @room.id).present?
      @messages = @room.messages
      @message = Message.new()
      @entries = @room.entries
      @anotherEntrie = @entries.find_by('user_id != ?',current_user.id)
    else
      redirect_back(fallback_location: root_path)
    end
  end
end
