const webpack = require('webpack');
const path = require('path');
const HtmlWebpackPlugin = require('html-webpack-plugin');

module.exports = {
    entry: './src/index.ts',
    module: {

        rules: [
            {
                include: [path.resolve(__dirname, 'src')],
                loader: 'ts-loader',
                test: /\.(j|t)sx?$/
            }
        ]
    },

    output: {
        chunkFilename: '[name].[chunkhash].js',
        filename: '[name].[chunkhash].js',
        path: path.resolve(__dirname, 'wwwroot')
    },

    mode: 'development',

    plugins: [
        new HtmlWebpackPlugin(),
    ],

    resolve: {
        extensions: [ '.wasm', '.mjs', '.js', '.json', '.ts', '.tsx' ],
    },

    optimization: {
        splitChunks: {
            cacheGroups: {
                vendors: {
                    priority: -10,
                    test: /[\\/]node_modules[\\/]/
                }
            },

            chunks: 'async',
            minChunks: 1,
            minSize: 30000,
            name: true
        }
    },

    devServer: {
      disableHostCheck: true
    }
};
