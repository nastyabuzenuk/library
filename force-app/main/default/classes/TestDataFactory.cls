@isTest
public class TestDataFactory {
    public static Reader__c createReader() {
        Reader__c testReader = new Reader__c();
        testReader.Name = 'Test';
        testReader.Email__c = testReader.Name + '@domain.com';
        insert testReader;
        return testReader;
    }

    public static Book__c createBook(){
        Book__c testBook = new Book__c();
        testBook.Name = 'Test Book';
        insert testBook;
        return testBook;
    }

    public static Subscription__c createSubsc(){
        Reader__c testReader = createReader();
        Book__c testBook = createBook();
        Subscription__c testSubsc = new Subscription__c();
        testSubsc.Reader__c = testReader.Id;
        testSubsc.Book__c = testBook.Id;
        testSubsc.StartDate__c = date.today();
        insert testSubsc;
        return testSubsc;
    }
}
