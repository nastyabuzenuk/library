@isTest
private class TriggerHandlerTest {
    @TestSetup
    static void data(){
        Subscription__c test = TestDataFactory.createSubsc();
    }

    @isTest
    static void addSubscriptionTest(){
        try{
        Test.startTest();
        Subscription__c testSubsc = new Subscription__c();
        Reader__c newReader = new Reader__c();
        newReader.Name = 'Test Trigger';
        newReader.Email__c = 'Test@domain.con';
        insert newReader;
        Book__c newBook = new Book__c();
        newBook.Name = 'Test Book for trigger';
        insert newBook;
        testSubsc.Reader__c = newReader.Id;
        testSubsc.Book__c =  newBook.Id;
        testSubsc.StartDate__c = date.today();
        insert testSubsc;

        Subscription__c testAnotherSubsc = new Subscription__c();
        testAnotherSubsc.Reader__c = newReader.Id;
        testAnotherSubsc.Book__c = newBook.Id;
        testAnotherSubsc.StartDate__c = date.today();
        insert testAnotherSubsc;
        Test.stopTest();
        System.assert(false); 
        } catch(Exception e){
            System.debug(e.getMessage());
            System.assertEquals(e.getMessage().contains('You can not create Subscription because it already exists'),true,'addSubscription working right');
        }
    }

    @isTest
    static void deleteBooksTest(){
        Id bookId = [SELECT Id FROM Book__c WHERE Name = 'Test Book' LIMIT 1].Id;
        Book__c bookToDelete = new Book__c(id =bookId);
        Test.startTest();
        delete bookToDelete;
        Test.stopTest();
        Reader__c debtor = [SELECT Debtor__c FROM Reader__c WHERE Name ='Test' LIMIT 1];
        Boolean isDebtor = false;
        If(debtor.Debtor__c == true){
            isDebtor=true;
        }
        System.assertEquals(true, isDebtor , 'deleteBooks  is working right');
    }
}
