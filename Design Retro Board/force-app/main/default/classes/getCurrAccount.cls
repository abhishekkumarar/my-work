public class getCurrAccount {
    @AuraEnabled(cacheable=true)
    public static Account getAccount(Id recordId) {
        return [Select Name, Email__c from Account where Id =: recordId];
    }
}