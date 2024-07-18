public with sharing class caseNumberOnAccountHelper {
    public static void updateCaseNumber(List<Case> cList) {
        Set<Id> accIds = new Set<Id>();

        if(!cList.isEmpty()){
            for(Case c : cList){
                if(c.AccountId != null){
                    accIds.add(c.AccountId);
                }
            }
        }

        if(!accIds.isEmpty()){
            Map<Id, Account> accMap = new Map<Id,Account>([Select Id, Latest_Case_Number__c from Account where Id IN : accIds]);

            Map<Id,Account> accMapToUpdate = new Map<Id,Account>();
            if(!cList.isEmpty()){
                for(Case c : cList){
                    if(accMap.containsKey(c.AccountId)){
                        Account a = accMap.get(c.AccountId);

                        if(a.Latest_Case_Number__c !=c.CaseNumber){
                            a.Latest_Case_Number__c = c.CaseNumber;
                            accMapToUpdate.put(a.Id, a);
                        }
                    }
                }
            }

            if(!accMapToUpdate.isEmpty()){
                update accMapToUpdate.values();
            }
        }
    }
}