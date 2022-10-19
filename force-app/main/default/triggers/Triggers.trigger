trigger Triggers on Subscription__c (before insert) {
    TriggerHandler.addSubscription(Trigger.new);
}