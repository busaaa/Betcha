class Group < ApplicationRecord

  has_many :group_users, class_name: 'GroupUser'
  has_many :users, through: :group_users
  has_many :messages
  has_many :bets

  def find_admin_id
    self.class.find(self.id).admin_id
  end

end
