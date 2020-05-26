const merge = require("webpack-merge")
const common = require("./webpack.common.js")

module.exports = merge(common, {
  // Use the compiler-included build of Vue
  resolve: {
    alias: {
      vue: "vue/dist/vue.js"
    }
  },

  output: {
    publicPath: "/build/"
  },

  module: {
    rules: [
      {
        test: /\.vue$/,
        loader: "vue-loader",
        options: {
          loaders: {
            js: "babel-loader"
          }
        }
      },
      {
        test: /\.(css|scss)$/,
        exclude: /node_modules/,
        use: ["style-loader", "css-loader","sass-loader"]
      }
    ]
  },

  // cheap-module-eval-source-map is faster for development
  devtool: "#cheap-module-eval-source-map"
})
