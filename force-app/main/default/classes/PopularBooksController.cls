public with sharing class PopularBooksController {
    @AuraEnabled
    public static List<Book__c> getTopBooks(){
        List<Subscription__c> listOfBooks = [SELECT Book__c FROM Subscription__c];
        for(Subscription__c item: listOfBooks){
            Book__c book = new Book__c(id=item.Book__c);
            List<AggregateResult> popul = [SELECT COUNT(Name)cnt FROM Subscription__c WHERE Book__c =:item.Book__c];
            for(AggregateResult agg: popul){
                book.Popularity__c = (decimal)agg.get('cnt');
            }
        }
        return [SELECT Id, Name, Author__c, Status__c FROM Book__c ORDER BY Popularity__c LIMIT 10];
    }
}
