module Aether
  class QuestController < ApplicationController
    def index
      fears = Aether::UserFear.joins(:fear).order('aether_user_fears.created_at')
                              .select('aether_user_fears.id', :name, :user_id, :priority)
      current_user_id = current_user.id
      @other_fears = []
      @user_fears = []
      fears.sort { |a, b| a.priority <=> b.priority }.select do |fear|
        ((fear.user_id == current_user_id) ? @user_fears : @other_fears) << fear
      end
    end

    def create
      user_id = current_user.id
      fear = Aether::Fear.find_or_initialize_by(name: params[:name], author_id: user_id)
      user_fear = Aether::UserFear.create(user_id: user_id, fear: fear) if fear.new_record? && fear.save
      render json: { success: !user_fear.nil? }
    end
  end
end
