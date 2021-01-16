const getStyleRule = require("@rails/webpacker/package/utils/get_style_rule");

module.exports = getStyleRule(/\.less$/i, false, [
  {
    loader: "less-loader",
    options: {
      lessOptions: {
        javascriptEnabled: true,
        modifyVars: {
          "@border-radius-base": "0.25em",
          "@box-shadow-base": "0 5px 10px 0 rgba(0, 0, 0, 0.1)",
          "@layout-body-background": "#f2f2f2",
          "@layout-header-background": "none",
          "@layout-header-padding": "0",
          "@layout-sider-background": "#174287",
          "@menu-dark-bg": "#174287",
          "@menu-dark-item-active-bg": "rgba(255, 255, 255, 0.1)",
          "@menu-inline-toplevel-item-height": "56px",
          "@menu-item-height": "56px",
          "@primary-color": "#209cee",
        },
      },
    },
  },
]);
