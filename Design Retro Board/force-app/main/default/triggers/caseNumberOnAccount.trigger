trigger caseNumberOnAccount on Case (after insert) {
    if(trigger.isAfter && trigger.isInsert){
        if(!trigger.new.isEmpty()){
            caseNumberOnAccountHelper.updateCaseNumber(trigger.new);
        }
    }
}