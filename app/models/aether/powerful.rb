class Aether::Powerful < ApplicationRecord
  belongs_to :author, class_name: 'User', inverse_of: :authored_powerfuls
  has_many :user_powerfuls
  has_many :users, through: :user_powerfuls
end
