class GroupUsersController < ApplicationController

  def destroy
    group_user_elem = GroupUser.find params[:id]
    if group_user_elem.user_id == Group.find(group_user_elem.group_id).admin_id
      flash[:danger] = "You cannot leave a group until you aare the admin of it"
    else
      group_user_elem = GroupUser.find params[:id]
      group_user_elem.destroy
      flash[:success] = "You're no longer a member in #{Group.find(group_user_elem.group_id).name} group."
    end
    redirect_to user_user_only_groups_path(group_user_elem.user_id)
  end

end
