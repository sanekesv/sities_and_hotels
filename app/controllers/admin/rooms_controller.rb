class Admin::RoomsController < ApplicationController
  before_action :set_room, only: [:show, :edit, :update, :destroy]
  before_action :set_hotel, only: [:index, :create, :new, :show]

  def index
    @rooms = @hotel.rooms.all
  end

  def show
  end

  def new
    @room = @hotel.rooms.new
  end

  def edit
  end

  def create
    @room = @hotel.rooms.new(room_params)

    respond_to do |format|
      if @room.save
        format.html { redirect_to admin_hotel_rooms_path(@hotel), notice: 'Room was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @room.update(room_params)
        format.html { redirect_to admin_hotel_rooms_path(@hotel), notice: 'Room was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @hotel = @room.hotel
    @room.destroy
    respond_to do |format|
      format.html { redirect_to admin_hotel_rooms_path(@hotel), notice: 'Room was successfully destroyed.' }
    end
  end

  private
    def set_room
      @room = Room.find(params[:id])
    end

    def set_hotel
      @hotel = Hotel.find(params[:hotel_id])
    end

    def room_params
      params.require(:room).permit(:hotel_id, :room_type)
    end
end
