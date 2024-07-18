trigger updateEmail on Account (after update) {
    Map<Id,Account> accMap = new Map<Id,Account>();

    if(trigger.isAfter && trigger.isUpdate){
            for(Account acc : trigger.new){
                if(acc.Email__c != null){
                    accMap.put(acc.Id, acc);
                }
         }
    List<Contact> conList = [Select Id, Email, AccountId from Contact where AccountId IN : accMap.keySet()];
    List<Contact> upCon = new List<Contact>();
    
    for(Contact con : conList){
        con.Email = accMap.get(con.AccountId).Email__c;
        upCon.add(con);
    }
    update upCon;
    }
}