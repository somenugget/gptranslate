import { createApp } from 'vue'
import { createRouter, createWebHistory } from 'vue-router'

import Translations from '@/views/Translations.vue'
import Translation from '@/views/Translation.vue'
import Home from '@/views/Home.vue'

const routes = [
  { path: '/', component: Home },
  { path: '/t', component: Translation },
]

const router = createRouter({
  history: createWebHistory(),
  routes,
})

const app = createApp(Translations)
app.use(router)
app.mount('#translations')
