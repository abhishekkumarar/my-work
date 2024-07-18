public class maxOppFieldHandler {
    public static void handelMaxOpp(List<Opportunity> oppList, Map<Id,Opportunity> oldMap) {
        Set<Id> accIds = new Set<Id>();
        Map<Id,Account> accToUp = new Map<Id,Account>();
        if(!oppList.isEmpty()){
            for(Opportunity opp : oppList){
                if(oldMap!=null){
                    if(opp.AccountId != oldMap.get(opp.Id).AccountId){
                        accIds.add(opp.AccountId);
                        accIds.add(oldMap.get(opp.Id).AccountId);
                    }
                    else {
                        accIds.add(oldMap.get(opp.Id).AccountId);
                    }
                }else {
                accIds.add(opp.AccountId);
                }
            }
        }

        List<AggregateResult> agg = [Select AccountId ids, sum(amount) amt from Opportunity where AccountId =: accIds Group By AccountId];

        if(!agg.isEmpty()){
            for(AggregateResult ag : agg){
                Account ac = new Account();
                ac.Id = (id)ag.get('ids');
                ac.Max_Opportunity__c = (Decimal)ag.get('amt');
                accToUp.put(ac.ID, ac);
            }
        }

        if(!accToUp.isEmpty()){
            update accToUp.values();
        }
    }
}