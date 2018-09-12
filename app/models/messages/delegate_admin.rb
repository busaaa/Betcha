class Messages::DelegateAdmin < Message

  after_initialize :set_subject, :set_content

  def set_subject
    self.subject = "Congrats! #{User.find(self.user_id).name} delegated the admin rights of #{Group.find(self.group_id).name} group to you"
  end


  # TODO ha már ugyanaz a négy set_content üzenet, ki kellene tenni az ősosztályba?
  def set_content
    self.content = "Hi #{User.find(Group.find(self.group_id).admin_id).name}!\n\n" + self.subject
  end

end
