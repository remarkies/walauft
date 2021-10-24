const baseURL = "https://walauft.ch/"
const prevImageURL = baseURL + 'PreviewImage.png'
const description = "Events und Parties in Zürich, Basel, Bern, St.Gallen und Luzern"
const title = "walauft"
const lang = "de-ch"
const color = '#ffffff'
export default {
  // Global page headers: https://go.nuxtjs.dev/config-head
 
  head: {
    title: title,
    htmlAttrs: {
      lang: lang
    },
    meta: [
      { charset: 'utf-8' },
      { name: 'viewport', content: 'width=device-width, initial-scale=1' },
      { hid: 'description', name: 'description', content: 'Events Partys in Zürich, Basel, Bern, St.Gallen und Luzern' },
      { name: 'format-detection', content: 'telephone=no' },


    ],
    link: [
      { rel: 'icon', type: 'image/x-icon', href: '/favicon.ico' },
      { hid: 'canonical', rel: 'canonical', href: baseURL },
      { rel: 'stylesheet', href: 'https://fonts.googleapis.com/css2?family=Roboto+Mono:ital,wght@0,300;0,400;0,500;1,700&display=swap" rel="stylesheet' },
      { hid: 'description', name: 'description', content: description },
      { name: 'image', content: prevImageURL },

      { name: 'og:type', content: 'website' },
      { name: 'og:url', content: baseURL },
      { name: 'og:title', content: title },
      { name: 'og:description', content: description },
      { name: 'og:image', content: prevImageURL },

      { name: 'twitter:card', content: 'summary_large_image' },
      { name: 'twitter:url', content: baseURL },
      { name: 'twitter:description', content: description },
      { name: 'twitter:image', content: prevImageURL },
    ]
  },

  // Global CSS: https://go.nuxtjs.dev/config-css
  css: [
    "~/styles/global.scss"
  ],

  // Plugins to run before rendering page: https://go.nuxtjs.dev/config-plugins
  plugins: [
    // {src: "~/plugins/fastClick.js", ssr: false}
  ],
  pwa: {
    meta: {
      /* meta options */
      mobileAppIOS: true,
      lang: lang,
      name: title,
      short_name: title,
      theme_color: color,
      background_color: color,
      description: description,
      nativeUI: true,
    },
    manifest: {
      name: title,
      short_name: title,
      description: description,
      lang: lang,
      useWebmanifestExtension: false,
      background_color: color,

    }
  },

  // Auto import components: https://go.nuxtjs.dev/config-components
  components: true,

  // Modules for dev and build (recommended): https://go.nuxtjs.dev/config-modules
  buildModules: [
    // https://go.nuxtjs.dev/typescript
    '@nuxt/typescript-build',
    '@nuxtjs/pwa',
  ],

  // Modules: https://go.nuxtjs.dev/config-modules
  modules: [
    '@nuxt/http',
    '@nuxtjs/robots',
  ],

  http: {
    // proxyHeaders: false
  },
  // Build Configuration: https://go.nuxtjs.dev/config-build
  build: {
  },
  server: {
    port: 8000, // default: 3000     
    host: '0.0.0.0', // default: localhost   
  },   // other configs 
  scrollBehavior: function (to, from, savedPosition) {
    if (savedPosition) {
      return savedPosition
    }
  }
}
