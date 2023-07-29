import { Application } from "@hotwired/stimulus"
import { registerControllers } from 'stimulus-vite-helpers'

const application = Application.start()

// Configure Stimulus development experience
application.debug = true
window.Stimulus   = application

console.log('Stimulus ⚡️ Rails')

const controllers = import.meta.glob('./**/*_controller.js', { eager: true })
registerControllers(application, controllers)
