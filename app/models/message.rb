class Message < ApplicationRecord
  has_many :messages
  belongs_to :user
  belongs_to :group
  belongs_to :message, optional: true

  scope :join_requests, -> { where(type: 'JoinRequest') }
  scope :delegate_admins, -> { where(type: 'DelegateAdmin') }
  scope :group_deleted, -> { where(type: 'GroupDeleted') }
  scope :tournament_deleted, -> { where(type: 'TournamentDeleted') }

  delegate :join_requests, :delegate_admins, :group_deleted, :tournament_deleted, to: :messages

end
