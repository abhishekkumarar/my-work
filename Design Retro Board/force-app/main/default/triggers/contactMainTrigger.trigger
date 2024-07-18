trigger contactMainTrigger on Contact (before insert, after insert) {
    if(trigger.isBefore && trigger.isInsert){
        contactMainTriggerHandler.updateParentAccount(trigger.new);
    }
}