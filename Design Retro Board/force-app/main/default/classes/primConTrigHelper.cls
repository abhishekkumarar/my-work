public with sharing class primConTrigHelper {
    public static void handleCon(List<Contact> conList, Map<Id,Contact> oldMap) {
        Set<ID> accIds = new Set<Id>();
        Map<Id,Integer> countMap = new Map<Id,Integer>();

        if(!conList.isEmpty()){
            for(Contact con : conList){
                if(oldMap != null){
                    if(oldMap.get(con.Id).AccountId != con.AccountId){
                        accIds.add(oldMap.get(con.Id).AccountId);
                        accIds.add(con.AccountId);
                    }
                    else {
                        accIds.add(con.AccountId);
                    }
                }
                else{
                    accIds.add(con.AccountId);
                }
            }
        }
        if(!accIds.isEmpty()){
            List<Contact> contactList = [Select Primary_Contact__c, Id, AccountId from Contact where AccountId IN : accIds 
            and Primary_Contact__c = true];

            if(!conList.isEmpty()){
                for(Contact conObj : contactList){
                    countMap.put(conObj.AccountId, contactList.size());
                }

                for(Contact c : conList){
                    if(c.Primary_Contact__c == true && countMap.containsKey(c.AccountId) && countMap.get(c.AccountId) > 0 && (oldMap == null || !oldMap.get(c.Id).Primary_Contact__c) ){
                        c.addError('Primary Con Already present');
                    }
                }
            }
        }

    }
}