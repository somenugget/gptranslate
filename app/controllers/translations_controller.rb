class TranslationsController < ApplicationController
  layout 'translations'

  def index; end

  def show
    @translation = @translations.find(params[:id])
  end

  def create; end

  def update; end

  def destroy; end
end
