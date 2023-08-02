class ApplicationController < ActionController::Base
  private

  def transfer_guest_to_user
    guest_user.translations.each do |translation|
      translation.update(user_id: current_user.id)
    end

    guest_user.reload
  end
end
