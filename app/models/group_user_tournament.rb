class GroupUserTournament < ApplicationRecord

  belongs_to :group_user
  belongs_to :tournament
  has_one :rule

  def self.user_groups_having_tournament u_id, tournament_id
    self.where(tournament_id: tournament_id).inject([]) { |arr, g_u_t| arr << g_u_t.group_user.group if g_u_t.group_user.user_id.to_s == u_id }
  end


end
