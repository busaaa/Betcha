class TournamentsController < ApplicationController

  def new
    @tournament = Tournament.new
  end

  def create
    Tournament.create! name: params[:tournament][:name], private: params[:private] ? current_user.id : nil
    redirect_to user_path(current_user)
  end

end
