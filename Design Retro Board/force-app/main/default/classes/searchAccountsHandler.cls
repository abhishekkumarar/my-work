public class searchAccountsHandler {
    @AuraEnabled(cacheable=true)
    public static List<Account> searchAcct(String searchTerm){
            String search = '%' + searchTerm + '%';
            return [Select Id, Name, Email__c,Industry from Account where Name Like :search];
        
    }
}