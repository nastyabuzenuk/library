trigger Triggers on Subscription__c (before insert) {
    if(Trigger.isBefore){
        if(Trigger.isInsert){
            TriggerHandler.addSubscription(Trigger.new);
        }
    }
}