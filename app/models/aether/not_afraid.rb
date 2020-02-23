class Aether::Not_afraid < ApplicationRecord
  belongs_to :author, class_name: 'User', inverse_of: :authored_not_afraids
  has_many :user_not_afraids
  has_many :users, through: :user_not_afraids
end
