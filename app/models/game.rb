class Game < ApplicationRecord

  belongs_to :tournament
  has_many :bets

end
