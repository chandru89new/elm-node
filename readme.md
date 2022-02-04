# Elm/Node using Elm's Platform.worker

A simple setup (for demo / bootstrap) to show how Elm can be used to interact with node.

That is, write all main code in Elm, but use them through node's repl.

## to get started:

```
> yarn build (this builds the Main.elm file)
```
```
> node (this starts the node REPL)
```
```
> .load index.js (this loads the index file in the REPL and you can start using the functions exposed in the index file)
```

## a small trick to add ports on index.js 

I used a simple map to setup all functions that talk to the ports in the app.

```js
['receiveFile', 'fileContents', 'showModel'].map(fname => {
  if (app.ports[fname]) {
    global[fname] = (arg = null) => app.ports[fname].send(arg)
  } else {
    global[fname] = () => { console.log('Your elm app does not have this function/port defined') }
  }
})
```

whenever you add a new incoming-port in your Elm app, add the name of the port to the list/array.