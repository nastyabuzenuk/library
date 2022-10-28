public class BookQuantityBatch implements Database.Batchable<sObject>, Schedulable, Database.Stateful {
    public Integer recordsProcessed = 0;

    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator(
            'SELECT Id, Name, Quantity__c FROM Book__c'
        );
    }

    public void execute(Database.BatchableContext bc, List<Book__c> scope){
        List<Book__c> newBooks = new List<Book__c>();
        Set<Id> booksToProceed  = new Set<Id>();
        for(Book__c b :scope){
            booksToProceed.add(b.Id);
        }
        List<Subscription__c> subsc = [SELECT Book__c, ReturnedDate__c FROM Subscription__c WHERE Book__c IN :booksToProceed];
        for(Book__c book: scope){
            Integer numberOfActiveSubsc = 0;
            for(Subscription__c s: subsc){
                if(s.ReturnedDate__c!= null && book.Id == s.Book__c) {
                    numberOfActiveSubsc++;
                }
            }
            if(book.Quantity__c <= numberOfActiveSubsc){
                book.Quantity__c = book.Quantity__c + 3;
                newBooks.add(book);
            }
            recordsProcessed++;
        }
        update newBooks;
    }

    public void finish(Database.BatchableContext bc){
        System.debug(recordsProcessed + ' records processed!');
    }

    public void execute(SchedulableContext context){
        BookQuantityBatch book = new BookQuantityBatch();
        Id batchId = Database.executeBatch(book);
    }
}
