const Joi = require('joi')

const logSchema = Joi.array().items(Joi.object({
    deviceUid: Joi.string(),
    level: Joi.string(),
    dateTime: Joi.date().timestamp(),
    message: Joi.string(),
    file: Joi.string(),
    function: Joi.string(),
    line: Joi.number(),
    iOSVersion: Joi.string(),
    thread: Joi.string(),
    deviceModel: Joi.string(),
    tags: Joi.array().items(Joi.string()),
    additionalInformation: Joi.object()
}))

exports.logSchema = logSchema