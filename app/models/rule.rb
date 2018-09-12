class Rule < ApplicationRecord

  belongs_to :tournament
  belongs_to :group_user_tournament
  has_many :bets

end
