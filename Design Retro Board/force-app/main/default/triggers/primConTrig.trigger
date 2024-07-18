trigger primConTrig on Contact (before insert, before update) {
    if(trigger.isBefore && trigger.isUpdate)
    {
        primConTrigHelper.handleCon(trigger.new, trigger.oldMap);
    }
    else if(trigger.isBefore &&  trigger.isInsert )
    {
        primConTrigHelper.handleCon(trigger.new, null);
    }
}