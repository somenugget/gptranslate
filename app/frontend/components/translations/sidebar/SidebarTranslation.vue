<template>
  <router-link
    :to="{ name: 'translation', params: { id: translation.id } }"
    class="flex justify-between gap-x-1 rounded-md p-2 leading-6 text-gray-700 hover:bg-gray-100"
    :class="{
      'bg-gray-200 hover:bg-gray-200': isActiveTranslation,
    }"
  >
    <div class="grow">
      <input
        ref="translationNameRef"
        v-model="translationName"
        type="text"
        class="w-full cursor-pointer border-0 bg-transparent p-0 px-1 focus:ring-0"
        :class="{ 'focus:!ring-1': isEditing }"
        :readonly="!isEditing"
        @keyup.enter="saveTranslationName"
        @blur="stopEditingIfNotButton"
      />
    </div>
    <div
      v-if="isEditing || isLoading"
      class="flex gap-1"
      :class="{
        'pointer-events-none opacity-25': isLoading,
      }"
    >
      <button type="button" @click.prevent.stop="saveTranslationName">
        <CheckIcon class="h-4 w-4" />
      </button>
    </div>
    <div v-else class="flex gap-1">
      <button type="button" @click.prevent.stop="startEditing">
        <PencilIcon class="h-4 w-4" />
      </button>
      <button type="button" @click.prevent.stop>
        <TrashIcon class="h-4 w-4" />
      </button>
    </div>
  </router-link>
</template>

<script>
import {
  CheckIcon,
  PencilIcon,
  TrashIcon,
  XMarkIcon,
} from '@heroicons/vue/24/outline'
import { useMutation } from '@tanstack/vue-query'

import { updateTranslation } from '@/api/translations'

export default {
  name: 'SidebarTranslation',
  components: { PencilIcon, TrashIcon, CheckIcon, XMarkIcon },
  props: {
    translation: {
      type: Object,
    },
  },
  setup(props) {
    const { mutateAsync, isLoading } = useMutation({
      mutationFn: ({ name }) => {
        return updateTranslation({
          id: props.translation.id,
          translation: { name },
        })
      },
    })

    return { update: mutateAsync, isLoading }
  },
  data() {
    return {
      isEditing: false,
      translationName: this.translation.name,
      initialTranslationName: this.translation.name,
    }
  },
  computed: {
    isActiveTranslation() {
      return (
        this.$router.currentRoute?.value?.params?.id ===
        this.translation.id.toString()
      )
    },
  },
  methods: {
    startEditing() {
      this.isEditing = true
      this.initialTranslationName = this.translationName

      this.$nextTick(() => {
        this.$refs.translationNameRef.focus()
        this.$refs.translationNameRef.setSelectionRange(0, 0)
        this.$refs.translationNameRef.scrollLeft = 0
      })
    },
    stopEditing() {
      this.isEditing = false
      this.translationName = this.initialTranslationName
    },
    stopEditingIfNotButton(event) {
      if (event.relatedTarget?.tagName !== 'BUTTON') {
        this.stopEditing()
      }
    },
    saveTranslationName() {
      // this.isLoading = true
      // console.log('saveTranslationName', this.isLoading)
      // console.log('saveTranslationName', this)
      this.update({ name: this.translationName })
        .then(() => {
          console.log(this)
          this.initialTranslationName = this.translationName
        })
        .finally(() => {
          // this.isLoading = false
          this.isEditing = false
        })
    },
  },
}
</script>
