# frozen_string_literal: true

class RoomsController < ApplicationController
  before_action :authenticate_user!

  def create
    room = Room.create
    room.entries.create(user_id: current_user.id)
    room.entries.create(user_id: params[:id])
    redirect_to message_path(room.id)
  end
end
