@isTest
public class BookQuantityBatchTest {
    @TestSetup
    static void makeData(){
        List<Reader__c> readers = new List<Reader__c>();
        for(Integer i=0; i<10;i++){
            readers.add(new Reader__c(Name = 'Reader' + i, Email__c = 'Reader@dom.com'));
        }
        insert readers;
        Book__c book = new Book__c(Name = 'Book', Quantity__c = 3);
        List<Subscription__c> subsc = new List<Subscription__c>();
        insert book;
        for(Integer i=0; i<10;i++){
            subsc.add(new Subscription__c(Reader__c = readers[i].Id, Book__c = book.Id, StartDate__c = date.today(), ReturnedDate__c = date.today()));
        }
        insert subsc;
    }

    @isTest
    static void testBatch(){
        Test.startTest();
        BookQuantityBatch bookBatch = new BookQuantityBatch();
        Id job1Id = Database.executeBatch(bookBatch);
        Test.stopTest();
        List<Book__c> testBooks = [SELECT Quantity__c FROM Book__c WHERE Name LIKE 'Book%'];
        for(Book__c b: testBooks){
            System.assertEquals(6,b.Quantity__c);
        }
    }
}
