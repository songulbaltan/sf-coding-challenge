public class SendSMSCtrl {
    @AuraEnabled
    public static String SendSMS(String phoneNo, String smsBody, String fromPhNumber){
        String accountSid = 'AC0cf1023a0a0caeb6d0ee56d74aedb2bf'; 
        String token = 'b432c23eb26c5de80cbc4b9e11d64a2c'; 
        String endPoint = 'https://api.twilio.com/2010-04-01/Accounts/'+accountSid+'/SMS/Messages.json';
        Blob creds = Blob.valueOf(accountSid+':' +token);
        HttpRequest req = new HttpRequest();
        Http http = new Http();
        HTTPResponse res = new HTTPResponse();
        req.setEndpoint(endPoint);
        req.setMethod('POST');
        String VERSION  = '3.2.0';
        req.setHeader('X-Twilio-Client', 'salesforce-' + VERSION);
        req.setHeader('User-Agent', 'twilio-salesforce/' + VERSION);
        req.setHeader('Accept', 'application/json');
        req.setHeader('Accept-Charset', 'utf-8');
        req.setHeader('Authorization', 'Basic '+EncodingUtil.base64Encode(creds));
        req.setBody('To=' + EncodingUtil.urlEncode(phoneNo, 'UTF-8') + '&From=' + EncodingUtil.urlEncode(fromPhNumber,'UTF-8') + '&Body=' + smsBody);
        if(!test.isrunningtest())
        {
            res = http.send(req);
 
           if(res.getStatusCode() == 201){
               return 'SMS Sent Successfully';
           } else{
               errorWrapper er = (errorWrapper)json.deserialize(res.getBody(), errorWrapper.class);
               throw newMessageException('Error : ' + er.message);
           }
       }
       else
       {
           return 'SMS class is running through test class';
       }
    }
 
    public class errorWrapper{
       String code;
       String message;
       String moreInfo;
       String status; 
   }
 
    private static AuraHandledException newMessageException(String message) {
        AuraHandledException e = new AuraHandledException(message);
        e.setMessage(message);
        return e;
    }
}