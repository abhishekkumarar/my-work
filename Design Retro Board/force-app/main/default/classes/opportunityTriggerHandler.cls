public with sharing class opportunityTriggerHandler {
    public static void updateAmount(List<Opportunity> oppList) {
        List<Account> accList = new List<Account>();
        for(Opportunity opp : oppList){
            if(opp.AccountId !=null && opp.Amount != null){
                Account ac = new Account();
                ac.Id = opp.AccountId;
                ac.Latest_Opp_Amount__c = opp.Amount;
                accList.add(ac);
            }
        }
        update accList;
    }
}