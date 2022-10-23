@isTest
private class LibraryDaoTest {
    @TestSetup
    static void data(){
        for(Integer i = 0; i<5; i++){
            Subscription__c test = TestDataFactory.createSubsc();
        }
    }

    @isTest
    static void getActiveSubscriptionsTest(){
        List<Reader__c> readerIds = [SELECT Id FROM Reader__c WHERE Name = 'Test'];
        List<Id> readerId = new List<Id>();
        for(Reader__c r: readerIds){
            readerId.Add(r.Id);
        }
        Test.startTest();
        List<Subscription__c> methodList = LibraryDao.getActiveSubscriptions(readerId[0]);
        Test.stopTest();
        System.assertEquals(1, methodList.size() , 'getActiveSubscriptions working right');
    }

    @isTest
    static void getAllSubscriptionsTest(){
        Integer limitr = 15;
        Integer offset = 1;
        Test.startTest();
        List<Subscription__c> methodList = LibraryDao.getAllSubscriptions(limitr, offset);
        Test.stopTest();
        System.assertEquals(4, methodList.size(),'getAllSubscriptions working right');
    }

    @isTest
    static void getReadersCountTest(){
        Test.startTest();
        List<AggregateResult> methodList = LibraryDao.getReadersCount();
        Test.stopTest();
        System.assertEquals(1, methodList.size(),'getReadersCount working right');
    }

    @isTest
    static void getReadersOfBookTest(){
        List<Book__c> bookIds = [SELECT Id FROM Book__c WHERE Name = 'Test Book'];
        List<Id> bookId = new List<Id>();
        for(Book__c b: bookIds){
            bookId.Add(b.Id);
        }
        Test.startTest();
        List<Reader__c> methodList = LibraryDao.getReadersOfBook(bookId[0]);
        Test.stopTest();
        System.assertEquals(1, methodList.size() , 'getReadersOfBook is working right');
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
        System.assertEquals(testList.size(), methodList.size() ,'getTerminatedBooks working right');
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
        System.assertEquals(testSet.size(), methodSet.size(), 'getTerminatedReaders working right');
    }
}
