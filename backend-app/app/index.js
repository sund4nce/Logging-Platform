import app from './app'

const { PORT = 5050 } = process.env
app.listen(PORT, () => console.log(`Listening on port ${5050}`))