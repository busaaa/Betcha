class GroupsController < ApplicationController

  def index
    @current_user_groups = Group.joins(:group_users).where(group_users: { user_id: current_user.id }).distinct.pluck(:id)
    @groups = current_user.admin_user? ? Group.all : Group.where.not(id: @current_user_groups)
  end

  def show
  end

  def update
    Group.find(params[:id]).update admin_id: params[:new_admin_id]
    unless tournaments_of_group = GroupUser.find_by(group_id: params[:id], user_id: current_user.id).tournaments.where(private: current_user.id)
      tournaments_of_group.each do |t_o_g|
        if t_o_g.group_users.map(&:group) > 1
          # TODO biztos, hogy csinálunk egy copy-t? hogy lesz hozzá CreatGroupTournamentben mindenkinek az update-elve a Tournament_id, hogy lesz hozzá a Rule és a Games éa a bets :( ?
          Tournament.create! name: t_o_g.name + "(copy)", private: params[:new_admin_id]
        elsif t_o_g.group_users.map(&:group) == 1
          t_o_g.first.update! private: params[:new_admin_id]
        end
      end
    end
    flash[:success] = "Successfully delegated admin rights to #{User.find(params[:new_admin_id]).name} of #{Group.find(params[:id].name)} group"
    Messages::DelegateAdmin.create user_id: current_user.id, receiver_id: params[:new_admin_id], group_id: params[:id]
    # TODO send email to the new admin that he has a message
    redirect_to user_user_only_groups_path(current_user.id)
  end

  def new
    @tournaments = Tournament.where(private: nil).or(Tournament.where(private: "#{current_user.id}"))
    @group = Group.new
  end

  def create
    new_group      = Group.create! name: params[:group][:name], admin_id: current_user.id
    new_group_user = GroupUser.create! group_id: new_group.id, user_id: current_user.id
    unless params[:tournaments].nil?
      params[:tournaments].each { |trnmnt| GroupUserTournament.create!(group_user_id: new_group_user.id, tournament_id: trnmnt) }
      trnmnt_names      = params[:tournaments].map{ |trnmnt| Tournament.find(trnmnt).name }.join(", ")
      tournament_string = ",  with the tournaments: #{trnmnt_names}"
    end
    flash[:success]   = "Successfully created a new group: #{new_group.name}" + tournament_string.to_s
    redirect_to user_path(current_user)
  end

  def destroy
    group = Group.find params[:id]
    group.destroy
    flash[:success] = "Successfully deleted group: #{group.name}"
    group.users.each do |group_user|
      next if group_user.id == group.admin_id
      Messages::GroupDeleted.create! user_id: current_user.id, receiver_id: group_user.id, group_id: params[:id]
      #TODO send emails as well
    end
    redirect_to user_user_only_groups_path(current_user.id)
  end

end
