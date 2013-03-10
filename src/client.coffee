request = require 'request'

exports.construct = ({ endpoint }) ->
  id = 1
  (method, params, callback) ->
    request 
      method: 'POST'
      url: endpoint
      json:
        jsonrpc: '2.0'
        method: method
        params: params
        id: id++
    , (err, res, body) ->
      return callback(err) if err
      return callback(new Error(body.error.data)) if body.error
      callback(null, body.result)
