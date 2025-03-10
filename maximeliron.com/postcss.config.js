module.exports = {
  syntax: "postcss-scss",
  plugins: {
    "postcss-strip-inline-comments": {},
    "postcss-simple-vars": {},
    "postcss-nested-vars": {},
    "postcss-extend-rule": {}, // doesn't work
    "@tailwindcss/nesting": {},
    "@tailwindcss/postcss": {},
  },
};
