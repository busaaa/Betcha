class GroupUser < ApplicationRecord

  has_many :group_user_tournaments, class_name: 'GroupUserTournament'
  has_many :tournaments, through: :group_user_tournaments

  belongs_to :user
  belongs_to :group

  def self.find_group_user_by_ids group_id, user_id
    GroupUser.find_by group_id: group_id, user_id: user_id
  end

  def self.find_tournaments_of group
    input = group.is_a?(Group) ? group.id : group
    GroupUser.find_by(group_id: input).tournaments
  end

end
