import { Router } from 'express'
import { elasticsearchBridge } from '../../core/ElasticsearchBridge'

const routes = Router()

routes.post('/add', async (req, res) => {

    try {
        const response = await elasticsearchBridge.addBulkLogs(req.body)

        if (response.data.errors) {
            return res.status(500).json({
                error: err
            })
        }

        return res.json(response.data)
    } catch(err) {

        return res.status(500).json({
            error: err
        })
    }
})

exports.logRoutes = routes