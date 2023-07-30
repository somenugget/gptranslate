module Api
  class BaseController < ApplicationController
    after_action :set_content_type

    def set_content_type
      response.headers['Content-Type'] = 'application/json'
    end
  end
end
