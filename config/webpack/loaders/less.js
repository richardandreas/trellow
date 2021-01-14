const getStyleRule = require("@rails/webpacker/package/utils/get_style_rule");

module.exports = getStyleRule(/\.less$/i, false, [
  {
    loader: "less-loader",
    options: {
      lessOptions: {
        javascriptEnabled: true,
        modifyVars: {
          "@border-radius-base": "0.25em",
          "@layout-sider-background": "#174287",
          "@menu-dark-bg": "#174287",
          "@menu-dark-item-active-bg": "rgba(255, 255, 255, 0.1)",
          "@primary-color": "#209cee",
        },
      },
    },
  },
]);
