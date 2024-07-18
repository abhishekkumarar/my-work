@isTest
public class updateBillingHandlerTest {
    @isTest public static void handleUpdateTest() {
        List<Account> accList = new List<Account>();
        List<Contact> conList = new List<Contact>();

        for(Integer i=0; i<3; i++){
            Account ac = new Account(Name='Test');
            ac.BillingCity = 'Bareilly';
            accList.add(ac);
        }

        insert accList;

        for(Account ac : accList){
            Contact co = new Contact();
            co.LastName = 'Test';
            co.AccountId = ac.Id;
            conList.add(co);
        }

        insert conList;

        for(Account acc : accList){
            acc.BillingCity = 'Bly';
        }

        update accList;

        List<Contact> con = [Select Id, MailingCity from Contact where Id =: conList[0].id ];

        System.assertEquals('Bly', con[0].MailingCity);
    }
}