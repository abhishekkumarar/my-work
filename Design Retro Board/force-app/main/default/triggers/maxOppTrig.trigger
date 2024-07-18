trigger maxOppTrig on Opportunity (after insert, after update, after delete, after undelete) {
    if(trigger.isAfter && trigger.isUpdate)
    {
        maxAmountTrigHelper.updateAmount(trigger.new, trigger.oldMap);
    }
    else if(trigger.isAfter && trigger.isDelete)
    {
        maxAmountTrigHelper.updateAmount(trigger.old, null);
    }
    else if(trigger.isAfter && ( trigger.isInsert || trigger.isUndelete ))
    {
        maxAmountTrigHelper.updateAmount(trigger.new, null);
    }
}