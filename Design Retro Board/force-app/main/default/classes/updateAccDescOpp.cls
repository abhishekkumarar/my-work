public class updateAccDescOpp {
    public static void updateAccDesc(List<Opportunity> oppList, Map<Id,Opportunity> oldMap) {
        Set<Id> accIds = new Set<Id>();
        List<Account> accToUp = new List<Account>();
        if(!oppList.isEmpty()){
            for(Opportunity opp : oppList){
                if(oldMap != null){
                    if(opp.AccountId != oldMap.get(opp.Id).AccountId){
                        accIds.add(opp.AccountId);
                        accIds.add(oldMap.get(opp.Id).AccountId);
                    }
                    else if(opp.Amount != oldMap.get(opp.id).Amount){
                        accIds.add(opp.AccountId);
                    }
                }
                else{
                    accIds.add(opp.AccountId);
                }
            }
        }

        if(!accIds.isEmpty()){
            List<Opportunity> oppToUp = [select Id, AccountId, Amount, Name from Opportunity where AccountId =: accIds and Amount != null];
            Map<Id, Opportunity> oppMap = new Map<Id,Opportunity>();
            

            if(!oppToUp.isEmpty()){
                for(Opportunity op : oppToUp){
                    if(!oppMap.containsKey(op.AccountId) || op.Amount > oppMap.get(op.AccountId).Amount){
                        oppMap.put(op.AccountId, op);
                    }
                }
            }
            for(Id ids: accIds){
                Account ac= new Account();
                ac.Id = ids;
                ac.Description = 'The Max Opp is ' + oppMap.get(ids).Name;
                accToUp.add(ac);
            }
        }
        if(!accToUp.isEmpty()){
            update accToUp;
        }
    }
}