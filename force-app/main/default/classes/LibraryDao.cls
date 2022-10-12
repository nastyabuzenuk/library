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
        List<Book__c> terminatedBooks = [SELECT Name FROM Book__c WHERE Status__c = 'Hold' LIMIT :limitr OFFSET :offset ];
        return terminatedBooks;
    }

    // public static Set<Id> getTerminatedReaders(){
    //     List<Book__c> termBooks = getTerminatedBooks(100,0);
    //     List<Id> bookIds = new List<Id>();
    //     for(Book__c b: termBooks){
    //         bookIds.add(b.Id);
    //     }
    //     Set<Id> termReaders = [SELECT Id FROM Reader__c WHERE Reader__r.Subscription__c.Book__c.Id IN :bookIds ];
    //     return termReaders;
    // }
}
