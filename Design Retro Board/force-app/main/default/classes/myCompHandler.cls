public with sharing class myCompHandler {
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts() {
        return [select Id, Name, Email__c from Account Limit 10];
    }
}