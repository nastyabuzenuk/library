@isTest
private class UtilsTest {
    @TestSetup
    static void makeData(){
        String groupByField = 'Name';
        List<Account> testAccList = new List<Account>();
        for(Integer i=0; i<20; i++){
            Account testAccount = new Account();
            testAccount.Name = 'Test Field';
            testAccList.Add(testAccount);
        }
        insert testAccList;
    }

    @isTest
    static void groupRecordByFieldTest(){
        List<Account> testAccList = [SELECT Name FROM Account LIMIT 100];
        Test.startTest();
        Map<String,List<Account>> methodMap = Utils.groupRecordByField('Name', testAccList);
        Test.stopTest();
        System.assertEquals(1, methodMap.size(), 'groupRecordByField working right');
    }

    @isTest
    static void getFieldValueFromSobjectListTest(){
        List<Account> accList = [SELECT Name FROM Account WHERE Name = 'Test Field'];
        Test.startTest();
        Set<String> testSet = Utils.getFieldValueFromSobjectList(accList, 'Name');
        Test.stopTest();
        System.assertEquals(1, testSet.size(), 'getFieldValueFromSobjectList working right');
    }
}
 