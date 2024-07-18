public class getContactsForAccount {
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts(Id accountId) {
        
        return [Select Id, Name from Contact where AccountId =:accountId ];
    }
}