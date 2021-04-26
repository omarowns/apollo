module.exports = {
  corePlugins: {
    preflight: true
  },
  purge: [],
  darkMode: false, // or 'media' or 'class'
  theme: {
    extend: {
      colors: {
        'cb-orange': '#ff6050'
      },
      backgroundImage: theme => ({
        'backdrop': "linear-gradient(to top right, black, #ff6050 125%)",
        'profile-image': "var(--profile-image-url)",
        'spotify-track-image': "linear-gradient(to top, var(--tw-gradient-stops)), var(--spotify-track-image-url)"
      })
    },
  },
  variants: {
    extend: {},
  },
  plugins: [
    require('@benface/tailwindcss-reset')
  ],
}
