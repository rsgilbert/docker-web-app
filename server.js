"use strict"

const express = require('express')
const fs = require('fs')


// Constants
const PORT = 8080
const HOST = '0.0.0.0'

// App 
const app = express()

const logPath = '/etc/my-logs/a.log'

app.get('/', (req, res) => {
    res.send('Hello there')
})

app.get('/log', (req, res) => {
    const data = fs.readFileSync(logPath);
    console.log('log data is:', data)
    res.send(data)
})

app.post('/log', (req, res) => {
    // use { flags: 'a' } to append and { flags: 'w' } to erase and write a new file
    // See: https://stackoverflow.com/a/9812799/10030693
    const logStream = fs.createWriteStream(logPath, { flags: 'a' })
    logStream.write('One extra line on' + Date.now())
    logStream.end('\n\n**\n\n');
    const data = fs.readFileSync(logPath);
    console.log('log data is:', data)
    res.send(data)
})



app.listen(PORT, HOST)
console.log(`Running on http://${HOST}:${PORT}`)