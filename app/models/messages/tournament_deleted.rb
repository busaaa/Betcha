class Messages::TournamentDeleted < Message

  attr_accessor :tournament_id

  after_initialize :set_subject, :set_content

  def set_subject
    self.subject = "Bad news! #{User.find(self.user_id).name} deleted tournament: #{Tournament.find(self.tournament_id).name} from #{Group.find(self.group_id).name} group"
  end


  # TODO ha már ugyanaz a három set_content üzenet, ki kellene tenni az ősosztályba?
  def set_content
    self.content = "Hi #{User.find(Group.find(self.group_id).admin_id).name}!\n\n" + self.subject
  end


end
