class UsersController < ApplicationController
  def my_portfolio
    @tracked_stocks = current_user.stocks
  end

  def friendships
    @friends = current_user.friends
  end

  def search
    if params[:friend].present?
      @friends = User.where(first_name: params[:friend])
      if @friends
        respond_to do |format|
          format.js { render partial: 'users/friendships_result' }
        end
      else
        respond_to do |format|
          flash.now[:alert] = 'Friend was not found'
          format.js { render partial: 'users/friendships_result' }
        end
      end
    else
      respond_to do |format|
        flash.now[:alert] = 'Please enter a friend name to search'
        format.js { render partial: 'users/friendships_result' }
      end
    end
  end
end
