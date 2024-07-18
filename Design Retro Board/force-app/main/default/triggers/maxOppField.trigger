trigger maxOppField on Opportunity (after insert, after update, after delete, after undelete) {
    if(trigger.isAfter){
        if(trigger.isInsert || trigger.isUndelete){
            maxOppFieldHandler.handelMaxOpp(trigger.new, null);
        }
        if(trigger.isUpdate){
            maxOppFieldHandler.handelMaxOpp(trigger.new, trigger.oldMap);
        }
        if(trigger.isDelete){
            maxOppFieldHandler.handelMaxOpp(trigger.old, null);
        }
    }
}