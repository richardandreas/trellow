const getStyleRule = require("@rails/webpacker/package/utils/get_style_rule");

module.exports = getStyleRule(/\.less$/i, false, [
  {
    loader: "less-loader",
    options: {
      lessOptions: {
        javascriptEnabled: true,
        modifyVars: {
          "@primary-color": "#209cee",
          "@border-radius-base": "0.25em",
        },
      },
    },
  },
]);
