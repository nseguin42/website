/** @type {import('tailwindcss').Config} */

const plugin = require('tailwindcss/plugin');
const fs = require('fs');
const path = require('path');

module.exports = {
  content: ['./js/**/*.js', '../lib/*_web.ex', '../lib/*_web/**/*.*ex'],
  theme: {
    colors: {
      slate: {
        DEFAULT: '#3b4252',
        50: '#F4F4F4',
        100: '#ECEFF4',
        200: '#E5E9F0',
        300: '#D8DEE9',
        400: '#A5ADBE',
        500: '#75829C',
        600: '#4C566A',
        700: '#434C5E',
        800: '#3B4252',
        900: '#2E3440'
      },
      red: {
        DEFAULT: '#A5434C',
        50: '#F4E4E5',
        100: '#EED5D8',
        200: '#E2B8BC',
        300: '#D79BA1',
        400: '#CB7E85',
        500: '#BF616A',
        600: '#A5434C',
        700: '#7D333A',
        800: '#552327',
        900: '#30141A'
      },
      fuchsia: {
        DEFAULT: '#B48EAD',
        50: '#FDFCFD',
        100: '#F5F0F4',
        200: '#E5D8E2',
        300: '#D5BFD1',
        400: '#C4A7BF',
        500: '#B48EAD',
        600: '#9E6C95',
        700: '#7E5476',
        800: '#5C3D57',
        900: '#3B2737'
      },
      teal: {
        DEFAULT: '#8FBCBB',
        50: '#E8F1F1',
        100: '#DCEAE9',
        200: '#C2DBDA',
        300: '#A9CBCA',
        400: '#8FBCBB',
        500: '#6CA7A6',
        600: '#528988',
        700: '#3D6665',
        800: '#284342',
        900: '#202E2D'
      },
      blue: {
        DEFAULT: '#81A1C1',
        100: '#D8DEE9',
        200: '#B8CADC',
        300: '#9CB5CE',
        400: '#81A1C1',
        500: '#5B85AE',
        600: '#45698D',
        700: '#334D67',
        800: '#243342',
        900: '#1e2a37'
      },
      yellow: {
        DEFAULT: '#EBCB8B',
        100: '#F9F5D7',
        200: '#F7EAD1',
        300: '#F1DBAE',
        400: '#EBCB8B',
        500: '#E3B65B',
        600: '#DAA02B',
        700: '#AF7F1E',
        800: '#805C16',
        900: '#4F3A0F'
      },
      green: {
        DEFAULT: '#6A8B4F',
        100: '#E2EADA',
        200: '#CDDBC0',
        300: '#B8CDA6',
        400: '#A3BE8C',
        500: '#86AA68',
        600: '#6A8B4F',
        700: '#4F673A',
        800: '#344326',
        900: '#1E2A1B'
      },
      orange: {
        DEFAULT: '#D08770',
        50: '#F3E1DB',
        100: '#EED4CC',
        200: '#E4BBAD',
        300: '#DAA18F',
        400: '#D08770',
        500: '#C26446',
        600: '#9C4D33',
        700: '#723826',
        800: '#482318',
        900: '#1E0F0A'
      }
    },
    fontFamily: {
      sans: [
        'Inter',
        'Helvetica Neue',
        'Helvetica',
        'Open Sans',
        'Segoe UI',
        'Roboto',
        'Oxygen',
        'Ubuntu',
        'Cantarell',
        'Fira Sans',
        'Droid Sans',
        'sans-serif'
      ],
      mono: [
        'Iosevka',
        'SFMono-Regular',
        'Menlo',
        'Monaco',
        'Consolas',
        'Liberation Mono',
        'Courier New',
        'monospace'
      ],
      serif: ['Noto Serif', 'Georgia', 'Cambria', 'Times New Roman', 'Times', 'serif']
    },
    extend: {
      colors: {
        brand: '#4c566a'
      }
    }
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/typography'),
    // only when LiveView classes are applied, for example:
    //
    //     <div class="phx-click-loading:animate-ping">
    //
    plugin(({addVariant}) =>
      addVariant('phx-no-feedback', ['.phx-no-feedback&', '.phx-no-feedback &'])
    ),
    plugin(({addVariant}) =>
      addVariant('phx-click-loading', ['.phx-click-loading&', '.phx-click-loading &'])
    ),
    plugin(({addVariant}) =>
      addVariant('phx-submit-loading', ['.phx-submit-loading&', '.phx-submit-loading &'])
    ),
    plugin(({addVariant}) =>
      addVariant('phx-change-loading', ['.phx-change-loading&', '.phx-change-loading &'])
    ),

    // Embeds Hero Icons (https://heroicons.com) into your app.css bundle
    // See your `CoreComponents.icon/1` for more information.
    //
    plugin(function ({matchComponents, theme}) {
      let iconsDir = path.join(__dirname, '../priv/hero_icons/optimized');
      let values = {};
      let icons = [
        ['', '/24/outline'],
        ['-solid', '/24/solid'],
        ['-mini', '/20/solid']
      ];
      icons.forEach(([suffix, dir]) => {
        fs.readdirSync(path.join(iconsDir, dir)).map((file) => {
          let name = path.basename(file, '.svg') + suffix;
          values[name] = {name, fullPath: path.join(iconsDir, dir, file)};
        });
      });
      matchComponents(
        {
          hero: ({name, fullPath}) => {
            let content = fs
              .readFileSync(fullPath)
              .toString()
              .replace(/\r?\n|\r/g, '');
            return {
              [`--hero-${name}`]: `url('data:image/svg+xml;utf8,${content}')`,
              '-webkit-mask': `var(--hero-${name})`,
              mask: `var(--hero-${name})`,
              'background-color': 'currentColor',
              'vertical-align': 'middle',
              display: 'inline-block',
              width: theme('spacing.5'),
              height: theme('spacing.5')
            };
          }
        },
        {values}
      );
    })
  ]
};
