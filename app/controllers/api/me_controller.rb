module Api
  class MeController < BaseController
    def show
      render json: current_or_guest_user
    end
  end
end
