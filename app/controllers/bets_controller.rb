class BetsController < ApplicationController

  def create
    #TODO mi van ha van penalty
    bets = params[:groups].inject([]) do |arr, group_id|
      rule = GroupUserTournament.find_by(group_user_id: GroupUser.find_by(group_id: group_id, user_id: params[:user_id]), tournament_id: params[:tournament_id]).rule
      arr << Bet.where(user_id: params[:user_id], game_id: params[:game_id], rule_id: rule, group_id: group_id).first_or_initialize
    end
    bets.each do |bet|
      bet.team1_bet = params[:team1_bet]
      bet.team2_bet = params[:team2_bet]
      bet.save!
    end
    redirect_to user_user_only_tournament_path(params[:user_id], params[:tournament_id])
  end

end
