public class getAccountForParent {
    @AuraEnabled(cacheable=true) 
    public static List<Account> getAccounts() {
        return [select Id, Name from Account];
    }
}