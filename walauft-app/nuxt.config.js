export default {
  // Global page headers: https://go.nuxtjs.dev/config-head
  head: {
    title: 'Walauft',
    htmlAttrs: {
      lang: 'de'
    },
    meta: [
      { charset: 'utf-8' },
      { name: 'viewport', content: 'width=device-width, initial-scale=1' },
      { hid: 'description', name: 'description', content: 'Events Partys in Zürich, Basel, Bern, St.Gallen und Luzern' },
      { name: 'format-detection', content: 'telephone=no' }
    ],
    link: [
      { rel: 'icon', type: 'image/x-icon', href: '/favicon.ico' },
      { hid: 'canonical', rel: 'canonical', href: 'https://walauft.ch/'},
      { rel: 'stylesheet', href: 'https://fonts.googleapis.com/css2?family=Roboto+Mono:ital,wght@0,300;0,400;0,500;1,700&display=swap" rel="stylesheet'}
    ]
  },

  // Global CSS: https://go.nuxtjs.dev/config-css
  css: [
    "~/styles/global.scss"
  ],

  // Plugins to run before rendering page: https://go.nuxtjs.dev/config-plugins
  plugins: [
  ],

  // Auto import components: https://go.nuxtjs.dev/config-components
  components: true,

  // Modules for dev and build (recommended): https://go.nuxtjs.dev/config-modules
  buildModules: [
    // https://go.nuxtjs.dev/typescript
    '@nuxt/typescript-build',
  ],

  // Modules: https://go.nuxtjs.dev/config-modules
  modules: ['@nuxt/http'
  ],

  http: {
    // proxyHeaders: false
  },
  // Build Configuration: https://go.nuxtjs.dev/config-build
  build: {
  }
}
