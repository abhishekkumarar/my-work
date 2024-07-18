trigger emailAccTrig on Account (after update) {
    if(trigger.isAfter && trigger.isUpdate){
        for(Account acc : trigger.new){
            mailTrigHandler.sendEm(trigger.new, trigger.oldMap);
        }
    }
}