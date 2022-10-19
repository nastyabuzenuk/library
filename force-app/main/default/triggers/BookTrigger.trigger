trigger BookTrigger on Book__c (before delete) {
    TriggerHandler.deleteBooks(Trigger.old);
}