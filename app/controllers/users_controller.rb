class UsersController < ApplicationController
  before_action :authenticate_user!

  def my_profile
    @user = current_user
  end

  def my_friends
    @friendships = current_user.friends
  end

  def my_places
    @places = current_user.places.page(params[:page]).per(18)
    render :layout => 'setting'
  end

  def search
    @users = User.search(params[:search_param])

    if @users
      @users = current_user.except_current_user(@users)
      render partial: 'friends/lookup'
    else
      render status: :not_found, nothing: true
    end
  end

  def add_friend
    @friend = User.find(params[:friend])
    current_user.friendships.build(friend_id: @friend.id)
    if current_user.save
      redirect_to my_friends_path
    else
      redirect_to my_friends_path, flash[:error] = "There was an error with adding user as friend"
    end
  end

  def show
    @user = User.find(params[:id])
  end
end
