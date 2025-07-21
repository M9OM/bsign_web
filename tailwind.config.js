// tailwind.config.js
module.exports = {
  plugins: [
    require('daisyui')
  ],
  daisyui: {
    themes: [
      {
        docuseal: {
          'color-scheme': 'light',
          primary: '#3B82F6',       // blue-500
          secondary: '#60A5FA',     // blue-400
          accent: '#2563EB',        // blue-600
          neutral: '#1E3A8A',       // deep blue (text/buttons)
          'base-100': '#F8FAFC',    // light background
          'base-200': '#E2E8F0',    // secondary background
          'base-300': '#CBD5E1',    // borders, muted UI
          'base-content': '#1E293B',// dark text
          '--rounded-btn': '1.9rem',
          '--tab-border': '2px',
          '--tab-radius': '.5rem'
        }
      }
    ]
  }
}
