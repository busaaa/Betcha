class Messages::JoinRequest < Message

  after_initialize :set_subject, :set_content

  def set_subject
    self.subject = "#{User.find(self.user_id).name} would like to join your #{Group.find(self.group_id).name} group"
  end

  def set_content
    self.content = "Hi #{User.find(Group.find(self.group_id).admin_id).name}!\n\n" + self.subject
  end

end
