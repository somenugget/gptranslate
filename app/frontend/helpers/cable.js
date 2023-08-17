import * as ActionCable from '@rails/actioncable'

const createConsumer = () => {
  window.App || (window.App = {})
  window.App.cable = window.App.cable
    ? window.App.cable
    : ActionCable.createConsumer()

  return window.App.cable
}

const createTranslationChannelSubscription = ({
  translationId,
  consumer = createConsumer(),
  mixin = {},
}) => {
  consumer.subscriptions.create(
    { channel: 'TranslationChannel', id: translationId },
    mixin,
  )
}

export { createTranslationChannelSubscription }
