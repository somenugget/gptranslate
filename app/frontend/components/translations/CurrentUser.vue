<template>
  <div>
    <Menu>
      <MenuItems class="absolute bottom-10">
        <MenuItem v-if="isUser">
          <form action="/users/sign_out" method="post">
            <input type="hidden" name="_method" value="delete" />
            <CsrfHiddenInput />
            <button type="submit" @click.stop>Log out</button>
          </form>
        </MenuItem>
        <MenuItem v-else>
          <a href="/auth">Log in</a>
        </MenuItem>
      </MenuItems>
      <MenuButton class="flex justify-between items-center w-full px-1">
        <span>
          {{ isUser ? fullName : 'Guest' }}
        </span>
        <EllipsisVerticalIcon class="w-5 h-5" />
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
