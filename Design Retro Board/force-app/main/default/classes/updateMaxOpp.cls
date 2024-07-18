public with sharing class updateMaxOpp {
    public static void updateAccDesc(List<Opportunity> newOpp, Map<Id, Opportunity> oldMap) {
        Set<Id> accIds = new Set<Id>();
        List<Account> accUp = new List<Account>();
        if(!newOpp.isEmpty()){
            for(Opportunity opp : newOpp){
                if(oldMap!= null){
                    if(newOpp.AccountId != oldMap.get(opp.Id).AccountId){
                        accIds.add(newOpp.AccountId);
                        accIds.add(oldMap.get(opp.Id).AccountId);
                    }
                    else if(newOpp.Amount != oldMap.get(opp.Id).Amount){
                        accIds.add(newOpp.AccountId);
                    }
                }else{
                    accIds.add(newOpp.AccountId);
                }
            }
        }

        if(!accIds.isEmpty()){
            List<Opportunity> oppUp = [Select Id, AccountId, Amount from Opportunity where AccountId =: accIds and Amount!= null];
            Map<Id,Opportunity> oppMap = new Map<Id,Opportunity>();

            for(Opportunity op : oppUp){
                if(oppMap.containsKey(op.AccountId) || oppUp.Amount > oppMap.get(op.AccountId).Amount){
                    oppMap.put(op.AccountId, op);
                }
            }
        }
        for(Id ids : accIds){
            Account ac = new Account();
            ac.Id = ids;
            ac.Descripiton = oppMap.get(ac.Id).Name;
            accToUp.add(ac);
        }

        if(!accToUp.isEmpty()){
            update accToUp;
        }
    }
}