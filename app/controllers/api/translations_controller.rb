module Api
  class TranslationsController < BaseController
    before_action :set_translations

    def index
      render json: @translations
    end

    def show
      @translation = @translations.find(params[:id])

      render json: @translation.as_json(include: :phrases)
    end

    def create; end

    def update; end

    def destroy; end

    private

    def set_translations
      @translations = current_or_guest_user.translations
    end
  end
end
