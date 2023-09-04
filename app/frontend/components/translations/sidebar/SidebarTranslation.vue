<template>
  <router-link
    :to="{ name: 'translation', params: { id: translation.id } }"
    class="flex justify-between gap-x-1 rounded-md p-2 leading-6 text-gray-700 hover:bg-gray-100"
    :class="{
      'bg-gray-200 hover:bg-gray-200': isActiveTranslation,
      'pointer-events-none bg-red-100 opacity-50 hover:bg-red-100': deleted,
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
      v-if="isEditing || isUpdating"
      class="flex gap-1"
      :class="{
        'pointer-events-none opacity-25': isUpdating,
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
      <button type="button" @click.prevent.stop="deleteConfirmationOpen = true">
        <TrashIcon class="h-4 w-4" />
      </button>
      <Confirm
        :open="deleteConfirmationOpen"
        :confirming="isDeleting"
        @cancel="deleteConfirmationOpen = false"
        @confirm="deleteConfirmation()"
      >
        Do you really want to delete the translation "{{ translationName }}"?
      </Confirm>
    </div>
  </router-link>
</template>

<script>
import { CheckIcon, PencilIcon, TrashIcon } from '@heroicons/vue/24/outline'
import { useMutation, useQueryClient } from '@tanstack/vue-query'

import { deleteTranslationFromCache } from '@/helpers/cache'
import { deleteTranslation, updateTranslation } from '@/api/translations'
import Confirm from '@/ui/Confirm.vue'

export default {
  name: 'SidebarTranslation',
  components: { PencilIcon, TrashIcon, CheckIcon, Confirm },
  props: {
    translation: {
      type: Object,
    },
  },
  setup(props) {
    const { mutateAsync: update, isLoading: isUpdating } = useMutation({
      mutationFn: ({ name }) => {
        return updateTranslation({
          id: props.translation.id,
          translation: { name },
        })
      },
    })

    const { mutateAsync: runDelete, isLoading: isDeleting } = useMutation({
      mutationFn: () => {
        return deleteTranslation({
          id: props.translation.id,
        })
      },
    })

    const queryClient = useQueryClient()

    return { update, isUpdating, runDelete, isDeleting, queryClient }
  },
  data() {
    return {
      isEditing: false,
      translationName: this.translation.name,
      initialTranslationName: this.translation.name,
      deleteConfirmationOpen: false,
      deleted: false,
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
      this.update({ name: this.translationName })
        .then(() => {
          this.initialTranslationName = this.translationName
        })
        .finally(() => {
          this.isEditing = false
        })
    },
    deleteConfirmation() {
      this.runDelete().then(() => {
        this.deleted = true
        this.deleteConfirmationOpen = false

        setTimeout(() => {
          deleteTranslationFromCache({
            queryClient: this.queryClient,
            translationId: this.translation.id,
          })
        }, 1000)

        if (
          this.$router.currentRoute?.value?.params?.id ===
          this.translation.id.toString()
        ) {
          this.$router.push({
            name: 'home',
          })
        }
      })
    },
  },
}
</script>
