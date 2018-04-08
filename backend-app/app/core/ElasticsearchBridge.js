import { logSchema } from './LogSchema'

const Axios = require('axios')
const Joi = require('joi')

class ElasticsearchBridgeError extends Error {}

class ElasticsearchBridge {

    constructor() {
        this.rootUrl = process.env.ELASTICSEARCH_URL || 'https://logging.mort3m.io/elasticsearch'
        this.authUsername = process.env.ELASTICSEARCH_USERNAME || 'elastic'
        this.authPassword = process.env.ELASTICSEARCH_PASSWORD || 'changeme' 

        console.log('Elasticsearch server: '+ this.rootUrl)
    }

    async addBulkLogs(logs) {

        const endpoint =  this.rootUrl + '/logs/log/_bulk'
        const result = Joi.validate(logs, logSchema)
            
        if (result.error != null) {
            throw result.error.message
        }
        
        var formattedLog = ''
        logs.forEach(element => {
            formattedLog += (`{"index":{}}\n${JSON.stringify(element)}\n`)
        })
        
        try {
            const response = await Axios.post(endpoint, formattedLog, { 
                headers: {
                    'Content-Type': 'application/json'
                },
                auth: {
                    username: this.authUsername,
                    password: this.authPassword
                }
            })

            return response
        } catch(err) {
            throw err
        }
    }
}

exports.elasticsearchBridge = new ElasticsearchBridge()