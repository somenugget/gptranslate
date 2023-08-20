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

    def create
      translation = current_or_guest_user.translations.create

      render json: translation
    end

    def update
      @translation = @translations.find(params[:id])

      if @translation.update(translation_params)
        render json: @translation
      else
        render json: { errors: @translation.errors }, status: :unprocessable_entity
      end
    end

    def destroy; end

    private

    def set_translations
      @translations = current_or_guest_user.translations
    end

    def translation_params
      params.require(:translation).permit(:name)
    end
  end
end
