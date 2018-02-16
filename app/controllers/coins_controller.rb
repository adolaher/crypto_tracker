require 'cryptocompare'
require 'json'
class CoinsController < ApplicationController

  before_action :authorize_user, except: [:index, :show]

  def index
  end

  def show
    @coin = Coin.find(params[:id])

    

    @coin_price = Cryptocompare::Price.find(@coin.name, 'USD')
    @coin_hist = Cryptocompare::HistoDay.find(@coin.name, 'USD')
    @coin_price_key = @coin_price.keys[0]
    @coin_price_value = @coin_price.values[0]["USD"]
    # @coin_deposit_date =
    # @historical_price = Cryptocompare::PriceHistorical.find(@coin.name, 'USD', {'ts' => 1452680400})
    # @historical_price_key = @historical_price.keys[0]
    # @historical_price_value = @historical_price.values[0]["USD"]
    #

    @comments = Comment.where(coin_id: @coin.id)
      @comment_rating = 0
      @comments.map { |comment|
        @comment_rating += comment.rating
      }
      @comment_rating = @comment_rating/@comments.length rescue 0


  end

  def new
    @user = current_user
    @coin = Coin.new
  end

  def create
    @coin = Coin.new(coin_params)
    @coin.user = current_user

    if @coin.save
      redirect_to coin_path(@coin.id)
      flash[:notice] = 'Coin added successfully'
    else
      flash[:error] = @coin.errors.full_messages.join(", ")
      render :new
    end

  end

  def edit
    @coin = Coin.find(params[:id])
  end

  def update
    @coin = Coin.find(params[:id])

    if @coin.update(coin_params)
      redirect_to coin_path(@coin)
    else
      render :edit
    end
  end

  def destroy
    @coin = Coin.find(params[:id])
    @coin.destroy
    redirect_to root_path
  end

  protected

  def coin_params
    params.require(:coin).permit(:name, :picture, :description)
  end


  def user_params
    params.require(:user).permit(:email, :encrypted_password)
  end

  def authorize_user
    if !user_signed_in?
      raise ActionController::RoutingError.new("Not Found")
    end
  end
end
