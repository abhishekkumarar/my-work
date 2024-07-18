public with sharing class closeOppTrigHelper {
    public static void handleOpp(List<Account> accList, Map<Id,Account> oldMap) {
        Set<Id> accIds = new Set<Id>();
        List<Opportunity> oppToUp = new List<Opportunity>();
        if(!accList.isEmpty()){
            for(Account acc : accList){
                if(acc.Close_Opps__c == true && oldMap.containsKey(acc.Id) && oldMap.get(acc.Id).Close_Opps__c == false){
                    accIds.add(acc.Id);
                }
            }
        }

        if(!accIds.isEmpty()){
            List<Opportunity> oppList = [Select AccountId, Id, StageName, CloseDate, Probability from Opportunity where AccountId In : accIds];

            if(!oppList.isEmpty()){
                for(Opportunity opp : oppList){
                    if(opp.Probability > 70 && opp.StageName != 'Closed Won'){
                        opp.StageName = 'Closed Won';
                        opp.CloseDate = Date.Today();
                        oppToUp.add(opp);
                    }
                }
            }
            if(!oppToUp.isEmpty()){
                update oppToUp;
            }
        }
    }
}