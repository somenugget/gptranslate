<template>
  <div></div>
  <TranslationsForm />
</template>

<script>
import { defineComponent } from 'vue'

import TranslationsForm from '@/components/translations/TranslationsForm.vue'

export default defineComponent({
  name: 'Home',
  components: { TranslationsForm },
})
</script>
