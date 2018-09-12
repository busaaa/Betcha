class MessagesController < ApplicationController

  def create
    group_admin = User.find(Group.find(params[:group_id]).admin_id)
    "Messages::#{params[:type]}".constantize.create! user_id: params[:user_id], receiver_id: group_admin.id, group_id: params[:group_id]
    group = Group.find(params[:group_id])
    flash[:success] = "A message has been sent to the admin (#{group_admin.name}) of the #{group.name} group with a join request"
    # TODO also send an email to admin with a link to view the message
    redirect_to groups_path
  end

end
