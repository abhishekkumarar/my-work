trigger accDeletion on Account (before delete) {
    if(trigger.isBefore && trigger.isDelete){
        if(!trigger.old.isEmpty()){
            for(Account acc : trigger.old){
                if(acc.Active_Status__c == true ){
                    acc.addError('Can not delete an Active Account');
                }
            }
        }
    }
}