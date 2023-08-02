<template>
  <div class="flex flex-col w-full h-screen">
    <div class="h-5/6"></div>
    <TranslationsForm />
  </div>
</template>

<script>
import { defineComponent } from 'vue'

import TranslationsForm from '@/components/translations/TranslationsForm.vue'
import TranslationsList from '@/components/translations/TranslationsList.vue'

export default defineComponent({
  name: 'Home',
  components: { TranslationsForm, TranslationsList },
})
</script>
