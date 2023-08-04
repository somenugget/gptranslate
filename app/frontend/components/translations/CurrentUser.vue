<template>
  <div class="relative">
    <Menu>
      <transition
        enter-active-class="transition duration-100 ease-out"
        enter-from-class="transform scale-95 opacity-0"
        enter-to-class="transform scale-100 opacity-100"
        leave-active-class="transition duration-75 ease-in"
        leave-from-class="transform scale-100 opacity-100"
        leave-to-class="transform scale-95 opacity-0"
      >
        <MenuItems
          class="absolute bottom-11 w-full rounded-md border bg-white p-2"
        >
          <MenuItem
            v-if="isUser"
            class="flex w-full items-center justify-between gap-x-3 rounded-md leading-6 text-gray-700 hover:bg-gray-100"
          >
            <form action="/users/sign_out" method="post">
              <input type="hidden" name="_method" value="delete" />
              <CsrfHiddenInput />
              <button type="submit" class="w-full p-2 text-left" @click.stop>
                Log out
              </button>
            </form>
          </MenuItem>
          <MenuItem v-else>
            <a href="/auth">Log in</a>
          </MenuItem>
        </MenuItems>
      </transition>
      <MenuButton
        class="flex w-full items-center justify-between gap-x-3 rounded-md p-2 leading-6 text-gray-700 hover:bg-gray-100"
      >
        <span>
          {{ isUser ? fullName : 'Guest' }}
        </span>
        <EllipsisVerticalIcon class="h-5 w-5" />
      </MenuButton>
    </Menu>
  </div>
</template>

<script>
import { defineComponent } from 'vue'
import { Menu, MenuButton, MenuItem, MenuItems } from '@headlessui/vue'
import { EllipsisVerticalIcon } from '@heroicons/vue/20/solid'

import CsrfHiddenInput from '@/ui/CsrfHiddenInput.vue'

export default defineComponent({
  name: 'CurrentUser',
  components: {
    Menu, // eslint-disable-line vue/no-reserved-component-names
    MenuButton,
    MenuItems,
    MenuItem,
    EllipsisVerticalIcon,
    CsrfHiddenInput,
  },
  computed: {
    isUser() {
      return !this.$currentUser?.guest
    },
    fullName() {
      return `${this.$currentUser?.firstName} ${this.$currentUser?.lastName}`
    },
  },
})
</script>
