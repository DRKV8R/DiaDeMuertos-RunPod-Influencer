module.exports = {
  content: [
    "./interface/templates/**/*.html",
    "./interface/src/**/*.js",
    "./interface/static/**/*.js"
  ],
  darkMode: 'class',
  theme: {
    extend: {
      colors: {
        'dia-orange': '#FF6B35',
        'dia-purple': '#6B46C1',
        'dia-gold': '#F59E0B',
        'dia-dark': '#0F0F0F',
        'dia-darker': '#050505'
      },
      animation: {
        'fade-in': 'fadeIn 0.5s ease-in-out',
        'slide-up': 'slideUp 0.3s ease-out',
        'glow': 'glow 2s ease-in-out infinite alternate',
        'float': 'float 3s ease-in-out infinite'
      },
      keyframes: {
        fadeIn: {
          '0%': { opacity: '0' },
          '100%': { opacity: '1' }
        },
        slideUp: {
          '0%': { transform: 'translateY(10px)', opacity: '0' },
          '100%': { transform: 'translateY(0)', opacity: '1' }
        },
        glow: {
          '0%': { boxShadow: '0 0 5px #FF6B35, 0 0 10px #FF6B35, 0 0 15px #FF6B35' },
          '100%': { boxShadow: '0 0 20px #FF6B35, 0 0 30px #FF6B35, 0 0 40px #FF6B35' }
        },
        float: {
          '0%, 100%': { transform: 'translateY(0px)' },
          '50%': { transform: 'translateY(-10px)' }
        }
      }
    }
  },
  plugins: [
    require('@tailwindcss/forms')
  ]
}