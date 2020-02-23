class Aether::UserNotAfraid < ApplicationRecord
  belongs_to :user
  belongs_to :not_afraid, class_name: 'Aether::NotAfraid'

  before_save :sort_priority

private

  def sort_priority
    others = if new_record?
               self.class.all
             else
               self.class.where.not(id: self.id)
             end.where(user: self.user).pluck(:priority).sort.reverse
    if self.priority.nil?
      self.priority = (others.first || 0) + 1
    elsif others.include?(self.priority)
      # Move others up a notch as there's overlap
      others.select { |other| other >= self.priority }.each do |num|
        Aether::UserNotAfraid.find_by(user: self.user, priority: num).update(priority: priority + 1)
      end
    end
  end
end
