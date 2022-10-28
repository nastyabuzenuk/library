public with sharing class Utils {
    public static Map<String,List<sObject>> groupRecordByField(String groupByField, List<sObject> recordsToBeGrouped) {
        List<sObject> recordsToAdd = new List<sObject>();
        Map<String,List<sObject>> groupedRecords = new Map<String,List<sObject>>();
        for(sObject oneObject: recordsToBeGrouped){
            if(oneObject.get(groupByField)!= NULL){
                recordsToAdd.add(oneObject);
            }
        }
        groupedRecords.put(groupByField, recordsToAdd);
        return groupedRecords;
    }

    public static Set<String> getFieldValueFromSobjectList(List<sObject> dataList, String fieldApiName){
        Set<String> fieldValues = new Set<String>();
        for(sObject data : dataList){
            if(data.get(fieldApiName)!= NULL){
                fieldValues.add(String.valueOf(data.get(fieldApiName)));
            }
        }
        return fieldValues;
    }
}
