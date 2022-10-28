public with sharing class PopularBooksController {
    @AuraEnabled
    public static List<Book__c> getTopBooks(){
        List<Subscription__c> listOfBooks = [SELECT Book__c FROM Subscription__c];
        Map<Book__c,List<Subscription__c>> mapOfBooks = new Map<Book__c,List<Subscription__c>>();
        for(Subscription__c book : listOfBooks){
            Book__c cbook = new Book__c(id=book.Book__c);
            mapOfBooks.put(cbook,[SELECT Name FROM Subscription__c WHERE Book__c =:book.Book__c]);
            cbook.Popularity__c = mapOfBooks.get(cbook).size();
        }
        return [SELECT Id, Name, Author__c, Status__c FROM Book__c ORDER BY Popularity__c LIMIT 10];
    }
}
