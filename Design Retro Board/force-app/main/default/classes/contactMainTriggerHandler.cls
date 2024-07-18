public with sharing class contactMainTriggerHandler {
    public static void updateParentAccount(List<Contact> conList) {
        Account ac = [select Id from Account where Name =: 'Test 1'];
        if(!conList.isEmpty()){
            for(Contact con : conList){
                if(con.AccountId == null){
                    con.AccountId = ac.Id;  
                   
                }
            }
        }
        
    }
}