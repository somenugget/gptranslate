<template>
  <article class="flex items-start justify-between gap-4">
    <div class="flex w-1/2 flex-col">
      <div class="flex items-center gap-x-4 text-xs">
        <span class="text-gray-500">{{ phrase.langFrom }}</span>
      </div>
      <div class="group relative">
        <p class="mt-1 whitespace-pre-wrap leading-6">
          {{ phrase.textFrom }}
        </p>
      </div>
    </div>

    <div class="flex w-1/2 flex-col">
      <div class="flex items-center justify-between gap-x-4 text-xs">
        <span class="text-gray-500">{{ phrase.langTo }}</span>
        <a
          v-if="showBadge"
          href="#"
          class="rounded-full px-2 py-1 font-medium text-gray-600"
          :class="badgeClass"
        >
          {{ phrase.status }}
        </a>
      </div>
      <div class="group relative">
        <p class="mt-1 whitespace-pre-wrap leading-6">
          {{ phrase.textTo }}
        </p>
      </div>
    </div>
  </article>
</template>

<script>
import { defineComponent } from 'vue'

export default defineComponent({
  name: 'Phrase',
  props: {
    phrase: {
      type: Object,
      default: undefined,
    },
  },
  computed: {
    showBadge() {
      return (
        this.phrase?.status === 'failed' || this.phrase?.status === 'pending'
      )
    },
    badgeClass() {
      return {
        'bg-red-100 text-red-800': this.phrase?.status === 'failed',
        'bg-yellow-100 text-yellow-800': this.phrase?.status === 'pending',
      }
    },
  },
})
</script>
