public with sharing class TriggerHandler {
    public static void addSubscription(List<Subscription__c> subsc){
        List<Id> bookId = new List<Id>();
        List<Id> readerId = new List<Id>();
        for(Subscription__c item: subsc){
            bookId.add(item.Book__c);
            readerId.add(item.Reader__c);
        }
        List<Subscription__c> subscItem = [SELECT Name FROM Subscription__c WHERE Book__c IN :bookId AND Reader__c IN :readerId];
        if(subscItem.size()>0){
            subscItem[0].addError('You can not create Subscription because it already exists');
        }
    }

    public static void deleteBooks(List<Book__c> books){
        List<Reader__c> readerToUpdate = new List<Reader__c>();
        List<Id> booksId = new List<Id>();
        for(Book__c book: books){
            booksId.add(book.Id);
        }
        List<Subscription__c> subsList = [SELECT Reader__c FROM Subscription__c WHERE Book__c IN :booksId];
        for(Subscription__c item: subsList){
           Reader__c reader = new Reader__c(id=item.Reader__c);
           reader.Debtor__c = true;
           readerToUpdate.add(reader);
        }
        try{
            update readerToUpdate;
        } catch (DMLException e){
            System.debug('An error occurred in deleteBooks in trigger '+ e.getMessage());
        }
    }
}
