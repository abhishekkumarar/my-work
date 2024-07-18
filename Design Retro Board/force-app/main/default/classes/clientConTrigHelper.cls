public with sharing class clientConTrigHelper {
    public static void handleClientCon(List<Account> accList) {
        List<Contact> conList = new List<Contact>();
        Set<Id> accIds = new Set<Id>();
        Map<Id,Account> accMap = new Map<Id,Account>();
        List<Account> accToUpList = new List<Account>();

        if(!accList.isEmpty()){
            for(Account acc : accList){
                Contact con = new Contact();
                con.AccountId = acc.Id;
                con.LastName = 'Test '+ acc.Name;
                conList.add(con);
                accIds.add(acc.Id);
            }
        }
        if(!conList.isEmpty()){
            insert conList;
        }
        
        if(!accIds.isEmpty()){
            List<Account> acctList = [Select Id, Client_Contact__c from Account where Id IN : accIds];

            if(!acctList.isEmpty()){
                for(Account acc : acctList){
                    accMap.put(acc.Id, acc);
                }
            }

            if(!conList.isEmpty()){
                for(Contact con : conList){
                    if(accMap.containsKey(con.AccountId)){
                        Account acc = accMap.get(con.AccountId);
                        acc.Client_Contact__c = con.Id;

                        accToUpList.add(acc);
                    }
                }
            }
        }
        if(!accList.isEmpty()){
            update accToUpList;
        }
    }
}