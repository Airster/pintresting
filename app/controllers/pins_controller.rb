class PinsController < ApplicationController
  before_action :set_pin, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def index #used to READ ALL
    @pins = Pin.all
  end

  def show #used as READ
  end

  def new #used by CREATE
    @pin = current_user.pins.build
  end

  def edit #used by UPDATE
  end

  def create #used by CREATE
    @pin = current_user.pins.build(pin_params)

      if @pin.save
        redirect_to @pin, notice: 'Pin was successfully created.' 
      else
        render :new 
      end

  end

  def update #used by UPDATE

      if @pin.update(pin_params)
        redirect_to @pin, notice: 'Pin was successfully updated.'
      else
        render :edit
      end

  end

  def destroy #used as DESTROY
    @pin.destroy
      edirect_to pins_url, notice: 'Pin was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pin
      @pin = Pin.find(params[:id])
    end

    def correct_user
      @pin = current_user.pins.find_by(id: params[:id])
      redirect_to pins_path, notice: "Not authorised to edit this pin" if @pin.nil?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pin_params
      params.require(:pin).permit(:description)
    end
end
