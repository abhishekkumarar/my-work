@AuraEnabled(cacheable = true)
public class getAccountDetails {
    public List<Account> getAccDetails(String accName) {
        return [Select Name, Email from Accounts where Name like : '%accName%']
    }
}