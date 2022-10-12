public with sharing class LibraryDao {
    public static List<Subscription__c> getActiveSubscriptions(Id readerId){
        List<Subscription__c> totalSubscribedBooks = 
            [SELECT Book__c 
            FROM Subscription__c 
            WHERE Reader__r.Id =: readerId];
        return totalSubscribedBooks;
    }

    public static List<Subscription__c> getAllSubscriptions(Integer limitr, Integer offset){
        List<Subscription__c> allSubSubscription = [SELECT Book__c,DaysOfHoldAllowed__c,HoldDuration__c,Reader__c,StartDate__c,ReturnedDate__c,Status__c  FROM Subscription__c LIMIT :limitr OFFSET :offset];
        return allSubSubscription;
    }

    public static List<AggregateResult> getReadersCount(){
        List<AggregateResult> allReaders = [SELECT COUNT(Reader__c) FROM Subscription__c];
        return allReaders;
    }

    public static List<Reader__c> getReadersOfBook(Id bookId){
        List<Subscription__c> readerIds = [SELECT Reader__r.Id FROM Subscription__c WHERE Book__r.Id =: bookId];
        List<Id> ids = new List<Id>();
        for(Subscription__c a: readerIds){
            ids.add(a.Reader__r.Id);
        }
        List<Reader__c> readersOfBook = [SELECT Name FROM Reader__c WHERE Id IN :ids];
        return readersOfBook;
    }

    public static List<Book__c> getTerminatedBooks(Integer limitr, Integer offset){
        List<Subscription__c> term = [SELECT Book__c FROM Subscription__c WHERE Status__c = 'Red Flag' LIMIT :limitr OFFSET :offset ];
        List<Book__c> terminatedBooks = new List<Book__c>();
        for(Subscription__c s: term){
            terminatedBooks.add(s.Book__r);
        }
        return terminatedBooks;
    }

    public static Set<Id> getTerminatedReaders(){
        Set<Id> termReaders = new Set<Id>();
        List<Subscription__c> listOfReaders = [SELECT Reader__c FROM Subscription__c WHERE Status__c = 'Red Flag'];
        for(Subscription__c s: listOfReaders){
            termReaders.add(s.Reader__r.Id);
        }
        return termReaders;
    }
}
