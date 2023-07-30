<template>
  <Sidebar />
  <router-view />
</template>

<script>
import { defineComponent } from 'vue'
import Sidebar from '@/components/translations/Sidebar.vue'
import { useQuery } from '@tanstack/vue-query'
export default defineComponent({
  name: 'translations',
  components: {
    Sidebar,
  },

  data() {
    return {
      msg: 'Welcome to Your Vue.js App',
    }
  },
})
</script>
