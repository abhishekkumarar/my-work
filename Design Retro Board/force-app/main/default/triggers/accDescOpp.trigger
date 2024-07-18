trigger accDescOpp on Opportunity (after insert, after update, after delete, after undelete) {
    if(trigger.isAfter){
        if(trigger.isInsert || trigger.isUndelete){
            updateAccDescOpp.updateAccDesc(trigger.new,null);
        }
        else if(trigger.isUpdate){
            updateAccDescOpp.updateAccDesc(trigger.new,trigger.oldMap);
        }
        else if(trigger.isDelete){
            updateAccDescOpp.updateAccDesc(trigger.old,null);
        }
    }
}