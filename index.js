const fs = require('fs')
const { Elm } = require('./main.js')

const app = Elm.Main.init({
  flags: null
})
app.ports.log.subscribe(console.log)

const loadFile = (file) => {
  const fileContents = fs.readFileSync(file, 'utf-8')
  app.ports.receiveFile.send(fileContents)
}


['receiveFile', 'fileContents', 'showModel'].map(fname => {
  if (app.ports[fname]) {
    global[fname] = (arg = null) => app.ports[fname].send(arg)
  } else {
    global[fname] = () => { console.log('Your elm app does not have this function/port defined') }
  }
})
