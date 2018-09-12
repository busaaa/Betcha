class GroupUserTournamentsController < ApplicationController

  def destroy
    g_u_t = GroupUserTournament.find params[:id]
    g_u_t.destroy
    current_group = g_u_t.group_user.group
    deleted_tournament = g_u_t.tournament
    flash[:success] = "Successfully deleted tournament: #{deleted_tournament.name} from group: #{current_group.name}"
    current_group.users.each do |user|
      next if user.id == current_user.id
      Messages::TournamentDeleted.create! user_id: current_user.id, receiver_id: user.id, group_id: current_group.id, tournament_id: deleted_tournament.id
      #TODO send emails as well
    end
    redirect_to user_user_only_group_path(current_user.id, current_group.id)
  end

end
