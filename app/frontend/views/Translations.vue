<template>
  <div>
    <h1>Translations</h1>
    <router-link to="/">Home</router-link> |
    <router-link to="/t">Tr</router-link>
    <router-view />
  </div>
</template>


<script>
export default {
  name: 'translations',
  data () {
    return {
      msg: 'Welcome to Your Vue.js App'
    }
  }
}
</script>
