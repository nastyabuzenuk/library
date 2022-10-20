trigger BookTrigger on Book__c (before delete) {
    if(Trigger.isBefore){
        if(Trigger.isDelete){
            TriggerHandler.deleteBooks(Trigger.old);
        }
    }
}