<template>
  <div class="mb-2 flex gap-2">
    <button
      class="grow rounded-md border border-slate-400 px-2 py-1 text-left transition hover:bg-slate-200"
      @click="createNewTranslation"
    >
      New translation
    </button>

    <button
      class="rounded-md border border-slate-400 px-2 py-1 transition hover:bg-slate-200"
    >
      <Bars3Icon class="h-5 w-5" />
    </button>
  </div>
</template>

<script>
import { Bars3Icon } from '@heroicons/vue/20/solid'
import { useQueryClient } from '@tanstack/vue-query'

import { addTranslationToCache } from '@/helpers/cache'
import { createTranslation } from '@/api/translations'

export default {
  name: 'TopPanel',
  components: {
    Bars3Icon,
  },
  setup() {
    const queryClient = useQueryClient()

    return { queryClient }
  },
  methods: {
    createNewTranslation() {
      createTranslation().then((translation) => {
        console.log(translation)
        addTranslationToCache({ translation, queryClient: this.queryClient })
        this.$router.push({
          name: 'translation',
          params: { id: translation.id },
        })
      })
    },
  },
}
</script>
