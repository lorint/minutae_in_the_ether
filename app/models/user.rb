require 'bcrypt'
class User < Type2
  has_secure_password validations: false
  has_many :requesters, class_name: "Tracking::Requester", foreign_key: :user_id
  belongs_to :referred_by, class_name: "User", optional: true

  has_many :user_roles
  has_many :roles, through: :user_roles
  has_many :user_videos
  has_many :videos, through: :user_videos

  has_many :authored_fears, class_name: 'Aether::Fear', inverse_of: :author
  has_many :user_fears, class_name: 'Aether::UserFear'
  has_many :fears, through: :user_fears

  has_many :authored_powerfuls, class_name: 'Aether::Powerful', inverse_of: :author
  has_many :user_powerfuls, class_name: 'Aether::UserPowerful'
  has_many :powerfuls, through: :user_powerfuls

  has_many :authored_not_afraids, class_name: 'Aether::NotAfraid', inverse_of: :author
  has_many :user_not_afraids, class_name: 'Aether::UserNotAfraid'
  has_many :not_afraids, through: :user_not_afraids

  validate :password_check

  private

  def password_check
    unless self.password.nil? || self.password.blank? || (self.password.length >= 6 && self.password == self.instance_variable_get(:@password_confirmation))
      self.errors.add(:password, "Must either be nil, blank or more than 5 characters long and password_confirmation must match the password.")
    end
  end
end
