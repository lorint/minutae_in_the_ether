module Aether
  class PowerfulController < ApplicationController
    def index
      powerfuls = Aether::UserPowerful.joins(:powerful).order('aether_user_powerfuls.created_at')
                              .select('aether_user_powerfuls.id', :name, :user_id, :priority)
      current_user_id = current_user.id
      @other_powerfuls = []
      @user_powerfuls = []
      powerfuls.sort { |a, b| a.priority <=> b.priority }.select do |powerful|
        ((powerful.user_id == current_user_id) ? @user_powerfuls : @other_powerfuls) << powerful
      end
    end

    def create
      user_id = current_user.id
      powerful = Aether::Powerful.find_or_initialize_by(name: params[:name], author_id: user_id)
      user_powerful = Aether::UserPowerful.create(user_id: user_id, powerful: powerful) if powerful.new_record? && powerful.save
      render json: { success: !user_powerful.nil? }
    end
  end
end
