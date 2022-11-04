@RestResource(urlMapping='/getTopReaders/*')
global with sharing class ReadersRestService {
    @HttpGet
    global static List<Reader__c> ReadersRestService() {
        return [
            SELECT Id, Name FROM Reader__c LIMIT 5
        ];
    }
}

