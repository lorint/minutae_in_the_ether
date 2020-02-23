class Aether::Fear < ApplicationRecord
  belongs_to :author, class_name: 'User', inverse_of: :authored_fears
  has_many :user_fears
  has_many :users, through: :user_fears
end
