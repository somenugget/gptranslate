class ApplicationController < ActionController::Base
  before_action :set_action_cable_identifier

  private

  def transfer_guest_to_user
    guest_user.translations.each do |translation|
      translation.update(user_id: current_user.id)
    end

    guest_user.reload
  end

  def set_action_cable_identifier
    cookies.encrypted[:guest_id] = guest_user.id unless current_user
  end
end
