class CommentsController < ApplicationController
  before_action :authorize_user, except: [:index, :show]

  def new
    @coin = Coin.find(params[:coin_id])
    @comment = Comment.new
  end

  def create
    @coin = Coin.find(params[:coin_id])

    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id

    @comment.coin = @coin
    @coin_price = Cryptocompare::Price.find(@coin.name, 'USD')
    @coin_price_value = @coin_price.values[0]["USD"]

    #date translation to unix
    @unix_parse = Date.parse(@comment.date)
    @coin_deposit_date = @unix_parse.to_time.to_i
    @initial_coin_deposit = @comment.initial_coin_deposit
    @historical_price = Cryptocompare::PriceHistorical.find(@coin.name, 'USD', {'ts' => @coin_deposit_date})

    @initial_investment_value = (@historical_price[@coin.name]["USD"] * @initial_coin_deposit)
    @current_investment_value = (@coin_price_value * @initial_coin_deposit)

    if @initial_investment_value < @current_investment_value
      @comment.value = ((@current_investment_value - @initial_investment_value) / @initial_investment_value) * 100
    else
      @comment.value = ((@initial_investment_value - @current_investment_value) / @initial_investment_value) * 100
    end

    # @comment.value = ((@coin_price_value * @comment.initial_coin_deposit) - (@historical_price[@coin.name]["USD"] * @comment.initial_coin_deposit))


    if @comment.save
      redirect_to coin_path(@coin.id)
      flash[:notice] = "Comment added successfully"
    else

      @comments = @coin.comments

      flash[:error] = @comment.errors.full_messages.join(", ")
      render :new
    end
  end

  def edit
    @coin = Coin.find(params[:coin_id])
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    @coin = Coin.find(params[:coin_id])

    if @comment.update(comment_params)
      redirect_to coin_path(@coin)
    else
      render :edit
    end
  end

  def destroy
    @coin = Coin.find(params[:coin_id])
    #@comments = Comment.where(coin_id: @coin.id)
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to coin_path(params[:coin_id])
  end

  def show
    @comment = Comment.find(params[:id])
    #shit i added
    #
    # @unix_parse = Date.parse(@comment.date)
    # @coin_deposit_date = @unix_parse.to_time.to_i
    # @initial_coin_deposit = comment.initial_coin_deposit
    #
    # @historical_price = Cryptocompare::PriceHistorical.find(@coin.name, 'USD', {'ts' => @coin_deposit_date})
    #
    # @comment.value = @coin_price_value - (@historical_price * @initial_coin_deposit)
    #
    # @historical_price_key = @historical_price.keys[0]
    # @historical_price_value = @historical_price.values[0]["USD"]

  end

  private

  def comment_params
    params.require(:comment).permit(:title, :rating, :price, :user_id, :coin_id, :body, :value, :date, :initial_coin_deposit)
  end

  def coin_params
    params.require(:coins).permit(:id)
  end

  def authorize_user
    if !user_signed_in?
      raise ActionController::RoutingError.new("Not Found")
    end
  end

end
