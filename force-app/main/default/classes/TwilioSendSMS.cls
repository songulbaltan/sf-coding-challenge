public class TwilioSendSMS {
    @InvocableMethod(label='Get Account Names' description='Returns the list of account names corresponding to the specified account IDs.' category='Account')
       public static List<String>getAccountNames(List<ID>ids){
           List<String>accountNames=new List<String>();
           List<Account>accounts= [SELECT Name FROM Account WHERE Id in :ids];
           for(Account account : accounts){
               accountnames.add(account.Name);
           }
           return accountNames;
       }
        public static void sendSms(){  
           String phNumber ='+447427411850';        
           String accountSid = 'AC0cf1023a0a0caeb6d0ee56d74aedb2bf';        
           String token = 'b432c23eb26c5de80cbc4b9e11d64a2c';        
           String fromPhNumber = '+14256009131';           
           String smsBody = 'Great News! A customer has hit Gold. <Account name> will get VIP treatment';        
           HttpRequest req = new HttpRequest();        
           req.setEndpoint('https://api.twilio.com/2010-04-01/Accounts/'+accountSid+'/SMS/Messages.json');        
           req.setMethod('POST');        
           String VERSION  = '3.2.0';        
           req.setHeader('X-Twilio-Client', 'salesforce-' + VERSION);        
           req.setHeader('User-Agent', 'twilio-salesforce/' + VERSION);       
           req.setHeader('Accept', 'application/json');        
           req.setHeader('Accept-Charset', 'utf-8');        
           req.setHeader('Authorization','Basic '+EncodingUtil.base64Encode(Blob.valueOf(accountSid+':' +token)));        
           req.setBody('To='+EncodingUtil.urlEncode(phNumber,'UTF-8')+'&From='+EncodingUtil.urlEncode(fromPhNumber,'UTF-8')+'&Body='+smsBody);        
           Http http = new Http();
           HTTPResponse res = new HTTPResponse(); 
            if(!test.isrunningtest())     
               res = http.send(req); 
                      
           System.debug(res.getBody());        
           if(res.getStatusCode()==201) 
           System.Debug('Message sending Successful');        
           else{            
               System.Debug('Message sending Unsuccessful');
           }        
       } 
   }