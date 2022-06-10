const AWS = require('aws-sdk');
exports.handler = async (event) => {
  try {
    const challengeAnswer = Math.random().toString(10).substr(2, 6);
    const phoneNumber = event.request.userAttributes.phone_number;
    const sns = new AWS.SNS({ region: 'us-east-1' });
    const messageAcknowledge = await sns.publish({
      Message: `OTP to Login News is ${challengeAnswer}`,
      PhoneNumber: phoneNumber,
      MessageStructure: 'string',
      MessageAttributes: {
        'AWS.SNS.SMS.SenderID': {
          DataType: 'String',
          StringValue: 'NEWS',
        },
        'AWS.SNS.SMS.SMSType': {
          DataType: 'String',
          StringValue: 'Transactional',
        },
      },
    }
    ).promise();
    console.log("sns responose: " + JSON.stringify(messageAcknowledge));
    event.response.privateChallengeParameters = {};
    event.response.privateChallengeParameters.answer = challengeAnswer;
    event.response.challengeMetadata = 'CUSTOM_CHALLENGE';
    return event;
  }
  catch (error) {
    console.log("inside catch error: " + error);
    return event;
  }
};
