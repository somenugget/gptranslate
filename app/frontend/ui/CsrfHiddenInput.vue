<template>
  <input type="hidden" :name="csrfParam" :value="csrfToken" />
</template>

<script>
import { defineComponent } from 'vue'

export default defineComponent({
  name: 'CsrfHiddenInput',
  computed: {
    csrfToken() {
      return document
        .querySelector('meta[name="csrf-token"]')
        .getAttribute('content')
    },
    csrfParam() {
      return document
        .querySelector('meta[name="csrf-param"]')
        .getAttribute('content')
    },
  },
})
</script>
