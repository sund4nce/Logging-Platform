import { Router } from 'express'
import { elasticsearchBridge } from '../../core/ElasticsearchBridge'

const routes = Router()

routes.post('/add', async (req, res) => {

    try {
        const response = await elasticsearchBridge.addBulkLogs(req.body)
        return res.json(response)
    } catch(err) {

        console.log(err)

        return res
            .status(500)
            .json({
                error: err.message
            })
    }
})

exports.logRoutes = routes