trigger closeOppTrig on Account (after update) {
    if(trigger.isAfter && trigger.isUpdate){
        closeOppTrigHelper.handleOpp(trigger.new, trigger.oldMap);
    }
}