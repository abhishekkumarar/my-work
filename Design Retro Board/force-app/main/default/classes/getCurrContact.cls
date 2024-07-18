public class getCurrContact {
    @AuraEnabled(cacheable=true)
    public static Contact getContact(Id recordId) {
        return [Select LastName, Email from Contact where Id =: recordId];
    }
}