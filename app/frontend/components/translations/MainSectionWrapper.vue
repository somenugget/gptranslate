<template>
  <div class="flex h-screen w-full flex-col justify-between p-4">
    <slot></slot>
  </div>
</template>

<script>
import { defineComponent } from 'vue'

export default defineComponent({
  name: 'MainSectionWrapper',
})
</script>
