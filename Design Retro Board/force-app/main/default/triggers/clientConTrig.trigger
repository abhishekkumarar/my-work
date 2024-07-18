trigger clientConTrig on Account (after insert) {
    if(trigger.isAfter && trigger.isInsert){
        clientConTrigHelper.handleClientCon(trigger.new);
    }
}