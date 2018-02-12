class Api::CoinsController < ApiController
  def index
    render json: Coin.all
  end

  def show
    render json: { coin: Coin.find(params[:id])}
  end
end
