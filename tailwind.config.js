module.exports = {
  plugins: [
    require('daisyui')
  ],
  daisyui: {
    themes: [
      {
        docuseal: {
          'color-scheme': 'light',
          primary: '#ffffffff',
          secondary: '#ef9fbc',
          accent: '#0f3ee8ff',
          neutral: '#0007d2ff',
          'base-100': '#faf7f5',
          'base-200': '#efeae6',
          'base-300': '#e7e2df',
          'base-content': '#20ff9eff',
          '--rounded-btn': '1.9rem',
          '--tab-border': '2px',
          '--tab-radius': '.5rem'
        }
      }
    ]
  }
}
