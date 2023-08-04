import { createApp } from 'vue'
import { createRouter, createWebHistory } from 'vue-router'
import {
  createInput,
  defaultConfig,
  plugin as FormKitPlugin,
} from '@formkit/vue'
import { VueQueryPlugin } from '@tanstack/vue-query'

import FormKitAutocomplete from '@/ui/FormKitAutocomplete.vue'
import Home from '@/views/Home.vue'
import Translation from '@/views/Translation.vue'
import Translations from '@/views/Translations.vue'

const routes = [
  { path: '/', component: Home },
  { path: '/t/:id', component: Translation, name: 'translation' },
]

const router = createRouter({
  history: createWebHistory(),
  routes,
})

const app = createApp(Translations)

app.use(VueQueryPlugin, {
  queryClientConfig: {
    defaultOptions: {
      queries: {
        refetchOnReconnect: false,
        refetchOnWindowFocus: false,
        retry: 1,
      },
    },
  },
})

app.use(
  FormKitPlugin,
  defaultConfig({
    inputs: {
      autocomplete: createInput(FormKitAutocomplete, {
        props: ['options', 'label', 'value'],
      }),
    },
  }),
)

const root = document.getElementById('translations')

try {
  const currentUser = JSON.parse(root.dataset.currentUser)
  const languages = JSON.parse(root.dataset.languages)
  app.config.globalProperties.$currentUser = currentUser
  app.config.globalProperties.$languages = languages
} catch {
  app.config.globalProperties.$currentUser = {}
  app.config.globalProperties.$languages = {}
}

app.use(router)
app.mount(root)
