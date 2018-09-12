class UserOnlyGroupsController < ApplicationController

  def index
    @user_groups = User.find(params[:user_id]).groups
  end

  def show
    @group = Group.find params[:id]
    @tournaments = GroupUser.find_tournaments_of params[:id]
  end

end
