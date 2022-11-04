public with sharing class LibraryService {
    public static void createSubscription(Id bookId, Id readerId){
        Subscription__c subscItem = new Subscription__c();
        subscItem.Book__c = bookId;
        subscItem.Reader__c = readerId;
        subscItem.StartDate__c = Date.today();
        try{
            insert subscItem;
        } catch (DMLException e){
            System.debug('An error occurred in createSubscription '+ e.getMessage());
        }
    }

    public static void closeSubscription(Id subscriptionId){
        Subscription__c currentSubsc = new Subscription__c(id= subscriptionId);
        currentSubsc.ReturnedDate__c = Date.today();
        try{
            update currentSubsc;
        } catch (DMLException e){
            System.debug('An error occurred in closeSubscription '+ e.getMessage());
        }
    }

    public static void createReader(String Name, String subscriptionType){
        Reader__c newReader = new Reader__c();
        newReader.Name = Name;
        newReader.Subscription_Type__c = subscriptionType;
        newReader.Email__c = Name + '@domain.com';
        try{
            insert newReader;
        } catch (DMLException e){
            System.debug('An error occurred in createReader '+ e.getMessage());
        }
    }

    public static void upgradeReader(List<Id> readerIds, String subscriptionType){
        List<Reader__c> upgradeReaders = new List<Reader__c>();
        for(Id read: readerIds){
            Reader__c readItem = new Reader__c(id= read);
            readItem.Subscription_Type__c = subscriptionType;
            upgradeReaders.add(readItem);
        }
        try{
            update upgradeReaders;
        } catch (DMLException e){
            System.debug('An error occurred in upgradeReader '+ e.getMessage());
        }
    }

    public static void deleteBooks(List<Id> bookIds){
        List<Book__c> booksToDelete = new List<Book__c>();
        for(Id bookId: bookIds){
            Book__c book = new Book__c(id= bookId);
            booksToDelete.add(book);
        }
        try{
            delete booksToDelete;
        } catch (DMLException e){
            System.debug('An error occurred in deleteBooks '+ e.getMessage());
        }
    }
}
