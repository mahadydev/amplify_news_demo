var https = require('https');

const authHeader = 'key=AAAAtmecRC8:APA91bGotSFHhWplCjNANJhAxD_OK6g0-crT6jsvToIdjYmOJoe4fwv7OOctgV_9z5yzLxFl3LXNAnQ4IxojeaddxTsmudjzl9akR9C2LjGL5PVEWij3550NNekXE6NipBCamzEU1ymN';
const deviceToken = 'eMRMHZE8QMGeKffqu67XS0:APA91bE4yd-y7qsrE16GHPLnNFHRq6n_4R0oUgmSSmnGpHeWab08zWtPYYrYZTv3fPWoYGfmrkxCa9yx_uljLhHTVfelQxNpSF1eE06ydFYdiVBpK0s15pyqUPQNrKcUZu606FedSGDy';


/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */
exports.handler = event => {
  console.log(`EVENT: ${JSON.stringify(event)}`);
  event.Records.forEach(record => {
    console.log(record.eventID);
    console.log(record.eventName);
    console.log('DynamoDB Record: %j', record.dynamodb);

    event.Records.forEach(function (record) {
      new Promise((resolve, reject) => {
        const options = {
          host: 'fcm.googleapis.com',
          path: '/fcm/send',
          method: 'POST',
          port: 443, // 👈️ replace with 80 for HTTP requests
          headers: {
            'Authorization': authHeader,
            'Content-Type': 'application/json',
          },
        }
        const req = https.request(options, (res) => {
          resolve('success')
        });
        req.on('error', (e) => {
          reject(e.message)
        });
        const reqBody = '{"to":"' + deviceToken + '", "priority": "high", "notification": {"title": "Test", "body": "record"}}'
        console.log(reqBody)
        req.write(reqBody)
        req.end()
      })

    })

  });
  return Promise.resolve('Successfully processed DynamoDB record');
};
