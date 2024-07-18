public with sharing class maxAmountTrigHelper {
    public static void updateAmount(List<Opportunity> oppList, Map<Id,Opportunity> oldMap) {
        Set<Id> accIds = new Set<Id>();
       
        if(!oppList.isEmpty()){
            for(Opportunity opp : oppList){
                if(oldMap!= null){
                    if(oldMap.get(opp.Id).AccountId != opp.AccountId){
                        accIds.add(oldMap.get(opp.Id).AccountId);
                        accIds.add(opp.AccountId);
                    }
                    else{
                        accIds.add(opp.AccountId);
                    }
                }
                else{
                    accIds.add(opp.AccountId);
                }
            }
        }

        List<AggregateResult> aggList = [Select AccountId ids, max(Amount) maxAmt from Opportunity where AccountId IN : accIds 
        group by AccountId];

        Map<Id,Account> accMap = new Map<Id,Account>();

        if(!aggList.isEmpty()){
            for(AggregateResult agg : aggList){
                Account ac = new Account();
                ac.Id =(Id)agg.get('ids');
                ac.Max_Opportunity__c = (Decimal)agg.get('maxAmt');
                accMap.put(ac.Id,ac);
            }
        }
        if(!accMap.isEmpty()){
            update accMap.values();
        }
    }
}