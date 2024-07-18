public with sharing class updateBillingHandler {
    public static void handleUpdate(List<Account> newList, Map<Id,Account> oldMap ) {
        List<Contact> conList = new List<Contact>();
        Map<Id,Account> accMap = new Map<Id,Account>();

    for(Account acc:newList){
        if(acc.BillingCity != oldMap.get(acc.Id).BillingCity){
            accMap.put(acc.Id,acc);
        }
    }

    if(!accMap.isEmpty()){
        List<Contact> cList = [Select Id, AccountId, MailingCity from Contact where AccountId =: accMap.keySet()];
        for(Contact con : cList){
                con.MailingCity = accMap.get(con.AccountId).BillingCity;
                conList.add(con);
        }
    }

    if(!conList.isEmpty()){
        update conList;
    }
    }
}