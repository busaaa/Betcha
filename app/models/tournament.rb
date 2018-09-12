class Tournament < ApplicationRecord

  has_many :group_user_tournaments, class_name: 'GroupUserTournament'
  has_many :group_users, through: :group_user_tournaments
  has_many :rules
  has_many :games

end
