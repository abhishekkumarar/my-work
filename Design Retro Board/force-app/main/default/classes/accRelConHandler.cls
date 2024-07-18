public with sharing class accRelConHandler {
    @AuraEnabled(cacheable=true)
    public static List<Account> getRelCon(){
        List<Account> accRelCon = [Select Id, Name, (Select Id, LastName, Email from Contacts) from Account limit 10];
        return accRelCon;
    }
}