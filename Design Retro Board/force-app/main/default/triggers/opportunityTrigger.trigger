trigger opportunityTrigger on Opportunity (after insert) {
    if(trigger.isAfter && trigger.isInsert){
        opportunityTriggerHandler.updateAmount(Trigger.new);
    }
}