import app from './app'

const { PORT = 1337 } = process.env
app.listen(PORT, () => console.log(`Listening on port ${1337}`))