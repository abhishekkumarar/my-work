trigger oppCheck on Account (after update) {
    List<Opportunity> oppListUpdated = new List<Opportunity>();
    Set<Id> accIds = new Set<Id>();

    if(trigger.isAfter && trigger.isUpdate){
        if(!trigger.new.isEmpty()){
            for(Account acc : trigger.new){
                accIds.add(acc.Id);
            }
        }
    }

    if(!accIds.isEmpty()){
        Date day30 = date.today()-30;

        List<Opportunity> oppList = [Select Id, Test_Created_Date__c, AccountId, stagename from Opportunity where AccountId IN : accIds];
        if(!oppList.isEmpty()){
            for(Opportunity o : oppList){
                if(o.Test_Created_Date__c < day30 && o.stagename != 'Closed Won'){
                    o.stagename = 'Closed Lost';
                    o.closeDate = date.today();
                    oppListUpdated.add(o);
                }
            }
        }
    }
    if(!oppListUpdated.isEmpty()){
        update oppListUpdated;
    }
}