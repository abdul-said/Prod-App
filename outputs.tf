(node:1) Warning: Accessing non-existent property 'count' of module exports inside circular dependency
(Use `node --trace-warnings ...` to show where the warning was created)
(node:1) Warning: Accessing non-existent property 'findOne' of module exports inside circular dependency
(node:1) Warning: Accessing non-existent property 'remove' of module exports inside circular dependency
(node:1) Warning: Accessing non-existent property 'updateOne' of module exports inside circular dependency
app listening on port 3000!
/home/app/server.js:61
    if (err) throw err;
             ^

MongoTimeoutError: Server selection timed out after 30000 ms
    at Timeout.<anonymous> (/home/app/node_modules/mongodb/lib/core/sdam/topology.js:878:9)
    at listOnTimeout (node:internal/timers:614:17)
    at process.processTimers (node:internal/timers:549:7) {
  reason: Error: connect ECONNREFUSED 127.0.0.1:27017
      at TCPConnectWrap.afterConnect [as oncomplete] (node:net:1634:16) {
    name: 'MongoNetworkError',
    errorLabels: [ 'TransientTransactionError' ],
    [Symbol(mongoErrorContextSymbol)]: {}
  },
  [Symbol(mongoErrorContextSymbol)]: {}
}

Node.js v23.6.1
