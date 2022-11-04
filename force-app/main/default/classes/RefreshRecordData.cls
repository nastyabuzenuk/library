public with sharing class RefreshRecordData {
    public class JSON2Apex{
        public String name;
        public String email;
        public String subscription;
        public String recordId;
        public Boolean debtor;
    }

    public static JSON2Apex parse(String json){
        return (JSON2Apex) System.JSON.deserialize(json,JSON2Apex.class);
    }

    @AuraEnabled
    public static void integrationCallout(Id recordId){
        HttpRequest req = new HttpRequest();
        req.setMethod('GET');
        req.setHeader( 'Content-Type', 'application/json' );  
        req.setHeader('objectName','Reader');
        req.setHeader('recordId', recordId);
        req.setEndpoint('https://avenga-school.herokuapp.com/retrieve-record');

        Http http = new Http();
        try {
            HttpResponse res = http.send(req);
            if(res.getStatusCode()== 200){
                System.debug(res.getBody());
                JSON2Apex obj = JSON2Apex.parse(res.getBody());
                Id id  = obj.recordId;
                Reader__c reader = new Reader__c(Id=id);
                reader.Name = obj.name;
                reader.Email__c = obj.email;
                reader.Subscription_Type__c = obj.subscription;
                reader.Debtor__c = obj.debtor;
                System.debug('sObject to upsert' + reader);
                upsert reader;
            }
            else {
                System.debug('The status code returned was not expected: ' + res.getStatusCode());
            }
            List<Reader__c> allReaders = [SELECT Id, Last_Sync_Date__c FROM Reader__c WHERE Id= :recordId];
            for(Reader__c r: allReaders){
                Reader__c reader = new Reader__c(Id = r.Id);
                reader.Last_Sync_Date__c = date.today();
            }
            update allReaders;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}