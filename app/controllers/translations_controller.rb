class TranslationsController < ApplicationController
  layout 'translations'

  def index
    render html: '', layout: true
  end
end
