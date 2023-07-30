class TranslationsController < ApplicationController
  layout 'translations'

  before_action :set_translations

  def index
  end

  def show
    @translation = @translations.find(params[:id])
  end

  def create
  end

  def update
  end

  def destroy
  end

  private

  def set_translations
    @translations = current_or_guest_user.translations
  end
end
