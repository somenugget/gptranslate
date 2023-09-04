<template>
  <TransitionRoot
    :show="open"
    as="template"
    enter="duration-300 ease-out"
    enter-from="opacity-0"
    enter-to="opacity-100"
    leave="duration-200 ease-in"
    leave-from="opacity-100"
    leave-to="opacity-0"
  >
    <Dialog class="relative z-50" @close="$emit('cancel')">
      <TransitionChild
        enter="duration-200 ease-out"
        enter-from="opacity-0"
        enter-to="opacity-100"
        leave="duration-200 ease-in"
        leave-from="opacity-100"
        leave-to="opacity-0"
      >
        <div class="fixed inset-0 bg-black/30" aria-hidden="true" />

        <div class="fixed inset-0 flex items-center justify-center">
          <DialogPanel class="w-1/2 rounded-lg bg-white p-4">
            <slot />
            <div class="mt-4 flex gap-2">
              <button
                class="rounded bg-green-500 px-2 py-1 text-white transition hover:bg-green-600"
                :disabled="confirming"
                @click="$emit('confirm')"
              >
                Confirm
              </button>
              <button
                class="rounded px-2 py-1 transition hover:bg-gray-100"
                @click="$emit('cancel')"
              >
                Cancel
              </button>
            </div>
          </DialogPanel>
        </div>
      </TransitionChild>
    </Dialog>
  </TransitionRoot>
</template>

<script>
import { defineComponent } from 'vue'
import {
  Dialog,
  DialogPanel,
  TransitionChild,
  TransitionRoot,
} from '@headlessui/vue'

export default defineComponent({
  name: 'Confirm',
  components: {
    TransitionChild,
    Dialog, // eslint-disable-line vue/no-reserved-component-names
    DialogPanel,
    TransitionRoot,
  },
  props: {
    open: { type: Boolean, required: true, default: false },
    confirming: { type: Boolean, required: true, default: false },
  },
  emits: ['cancel', 'confirm'],
})
</script>
