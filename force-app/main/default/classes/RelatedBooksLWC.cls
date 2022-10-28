public with sharing class RelatedBooksLWC {
    @AuraEnabled(cacheable=true)
    public static List<Book__c> getRelatedBooks(String readerId){
        List<Subscription__c> relatedBooks = [SELECT Book__c, Book__r.Name, Book__r.Author__c FROM Subscription__c WHERE Reader__c = :readerId AND CALENDAR_YEAR(StartDate__c) = 2022];
        List<Book__c> books = new List<Book__c>();
        for(Subscription__c item: relatedBooks){
            Book__c book = new Book__c(id=item.Book__c, Name = item.Book__r.Name, Author__c = item.Book__r.Author__c);
            books.Add(book);
        }
        return books;
    }
}
