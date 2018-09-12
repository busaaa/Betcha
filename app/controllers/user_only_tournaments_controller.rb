class UserOnlyTournamentsController < ApplicationController

  def index
    @user_tournaments = GroupUser.where(user_id: params[:user_id]).each_with_object([]) { |group_user, arr| arr.concat(group_user.tournaments.to_a) }.uniq
  end

  def show
    @tournament = Tournament.find params[:id]
    @games = @tournament.games
    #TODO ok, hogy lehet ezt normálisan megoldani, hogy legyen bent egy ALL GROUPS mező kiválaszthatók közt anélkül h létrehoznék csak emiatt egy kamu ALL GROUPS Groupot?
    @groups = [Group.find_by_name("ALL GROUPS")] + GroupUserTournament.user_groups_having_tournament(params[:user_id], @tournament.id)
  end

end
