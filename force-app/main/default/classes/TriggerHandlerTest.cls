@isTest
private class TriggerHandlerTest {
    @TestSetup
    static void data(){
        Subscription__c test = TestDataFactory.createSubsc();
    }

    @isTest
    static void addSubscriptionTest(){
        try{
        Subscription__c test = TestDataFactory.createSubsc();
        } catch(Exception e){
            System.assertEquals(e.getMessage().contains('You can not create Subscription because it already exists'),true,'addSubscription working right');
        }
    }

    @isTest
    static void deleteBooksTest(){
        Id bookId = [SELECT Id FROM Book__c WHERE Name = 'Test Book' LIMIT 1].Id;
        Book__c bookToDelete = new Book__c(id =bookId);
        delete bookToDelete;
        Reader__c debtor = [SELECT Debtor__c FROM Reader__c WHERE Name ='Test' LIMIT 1];
        Boolean isDebtor = false;
        If(debtor.Debtor__c == true){
            isDebtor=true;
        }
        System.assertEquals(true, isDebtor , 'deleteBooks  is working right');
    }
}
