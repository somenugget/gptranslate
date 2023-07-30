import { createApp } from 'vue'
import { createRouter, createWebHistory } from 'vue-router'
import { VueQueryPlugin } from '@tanstack/vue-query'

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

app.use(router)
app.mount('#translations')
