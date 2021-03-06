class User < ActiveRecord::Base

  has_many :group_users, class_name: 'GroupUser'
  has_many :groups, through: :group_users
  has_many :messages
  has_many :delegate_admins, class_name: 'Delegate_Admin'
  has_many :join_requests, class_name: 'Join_Request'
  has_many :bets

  attr_accessor :remember_token, :activation_token

  before_save   :downcase_email
  before_create :create_activation_digest
  validates     :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates     :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  has_secure_password

  validates     :password, presence: true, length: { minimum: 6 }, allow_nil: true, if: :password_digest_changed?
  validates     :password_confirmation, presence: true, if: :password_digest_changed?

  def self.digest string
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = self.class.new_token
    update!(:remember_digest => self.class.digest(remember_token))
  end

  def authenticated? attribute, token
    digest = send("#{attribute}_token")
    digest.nil? ? false : BCrypt::Password.new(digest).is_password?(token)
  end

  def forget
    update(:remember_digest => nil)
  end

  def activate
    update(activated: true)
    update(activated_at: Time.zone.now)
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  def admin_user?
    self.permission == "admin"
  end

  def self.find_group_members_but_admin_in group
    self.joins(:group_users).where(group_users: { group_id: group.id }).where.not(group_users: { user_id: group.find_admin_id }).distinct
  end

  private

    def downcase_email
      self.email = email.downcase
    end

    def create_activation_digest
      self.activation_token = self.class.new_token
      self.activation_digest = self.class.digest activation_token
    end

end
