module GroupsHelper

  def user_admin_in? group
    group.admin_id == current_user.id
  end

  def admin_of group
    User.find group.admin_id
  end

end
