@isTest
private class LibraryDaoTest {
    @TestSetup
    static void data(){
        Subscription__c test = TestDataFactory.createSubsc();
    }

    @isTest
    static void getActiveSubscriptionsTest(){
        List<Subscription__c> testList = [SELECT Book__c 
        FROM Subscription__c 
        WHERE Reader__r.Name = 'Test'];
        Id readerId = [SELECT Id FROM Reader__c WHERE Name = 'Test'].Id;
        Test.startTest();
        List<Subscription__c> methodList =  LibraryDao.getActiveSubscriptions(readerId);
        Test.stopTest();
        System.assertEquals(testList, methodList , 'getActiveSubscriptions working right');
    }

    @isTest
    static void getAllSubscriptionsTest(){
        Integer limitr = 15;
        Integer offset = 1;
        Test.startTest();
        List<Subscription__c> methodList = LibraryDao.getAllSubscriptions(limitr, offset);
        Test.stopTest();
        List<Subscription__c> testList = [SELECT Book__c,DaysOfHoldAllowed__c,HoldDuration__c,Reader__c,StartDate__c,ReturnedDate__c,Status__c  FROM Subscription__c LIMIT :limitr OFFSET :offset];
        System.assertEquals(testList.size(), methodList.size(),'getAllSubscriptions working right');
    }

    @isTest
    static void getReadersCountTest(){
        List<AggregateResult> allReaders = [SELECT COUNT(Reader__c) FROM Subscription__c];
        Test.startTest();
        List<AggregateResult> methodList = LibraryDao.getReadersCount();
        Test.stopTest();
        System.assertEquals(allReaders, methodList,'getReadersCount working right');
    }

    @isTest
    static void getReadersOfBookTest(){
        Id bookId = [SELECT Id FROM Book__c WHERE Name = 'Test Book'].Id;
        List<Reader__c> testList = [SELECT Name FROM Reader__c WHERE Email__c = 'Test@domain.com'];
        Test.startTest();
        List<Reader__c> methodList = LibraryDao.getReadersOfBook(bookId);
        Test.stopTest();
        System.assertEquals(testList, methodList , 'getReadersOfBook is working right');
    }

    @isTest
    static void getTerminatedBooksTest(){
        Integer limitr = 15;
        Integer offset = 1;
        List<Subscription__c> term = [SELECT Book__c FROM Subscription__c WHERE Terminated__c = true LIMIT :limitr OFFSET :offset ];
        List<Book__c> testList = new List<Book__c>();
        for(Subscription__c s: term){
            testList.add(s.Book__r);
        }
        Test.startTest();
        List<Book__c> methodList = LibraryDao.getTerminatedBooks(limitr, offset);
        Test.stopTest();
        System.assertEquals(testList, methodList ,'getTerminatedBooks working right');
    }

    @isTest
    static void getTerminatedReadersTest(){
        Set<Id> testSet = new Set<Id>();
        List<Subscription__c> listOfReaders = [SELECT Reader__c FROM Subscription__c WHERE Terminated__c = true];
        for(Subscription__c s: listOfReaders){
            testSet.add(s.Reader__c);
        }
        Test.startTest();
        Set<Id> methodSet = LibraryDao.getTerminatedReaders();
        Test.stopTest();
        System.assertEquals(testSet, methodSet, 'getTerminatedReaders working right');
    }
}
