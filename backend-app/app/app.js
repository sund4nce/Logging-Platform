import express from 'express'
import bodyParser from 'body-parser'
import path from 'path'
import logger from 'morgan'
import { Client } from 'elasticsearch'

import { logRoutes } from './routes/v1/log';
 
const app = express()
app.disable('x-powered-by')
app.use(bodyParser.json())
app.use(bodyParser.urlencoded({ extended: false }))
app.set('view engine', 'ejs')
app.set('views', path.join(__dirname, 'views'))

app.use(logger('dev', {
    skip: () => app.get('env') === 'test'
}))

app.use('/api/v1/log', logRoutes)

// Catch 404 and forward to error handler
app.use((req, res, next) => {
    const err = new Error('Not Found')
    err.status = 404
    next(err)
})

// Error handler
app.use((err, req, res, next) => {
    res
        .status(err.status || 500)
        .send(err.message)
})

export default app