class TranslationChannel < ApplicationCable::Channel
  def subscribed
    stream_from "translation_#{params[:id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
