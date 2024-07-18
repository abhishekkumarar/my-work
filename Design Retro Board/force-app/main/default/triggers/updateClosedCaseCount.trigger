trigger updateClosedCaseCount on Case (after update){
    if(trigger.isAfter && trigger.isUpdate){
        updateClosedCaseCountHandler.handleCount(Trigger.new);
    }
}