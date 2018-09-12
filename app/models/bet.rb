class Bet < ApplicationRecord
  belongs_to :user
  belongs_to :game
  belongs_to :group
  belongs_to :rule
end
