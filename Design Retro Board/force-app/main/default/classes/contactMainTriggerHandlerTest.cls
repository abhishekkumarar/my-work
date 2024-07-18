@isTest
public with sharing class contactMainTriggerHandlerTest {
    @isTest public static void updateAccount() {
        Account acc = new Account(Name = 'Test 1');
        insert acc;

        List<Contact> conList = new List<Contact>();
        for(Integer i=0; i<3 ;i++){
        Contact con = new Contact(LastName = 'Test 22');
        conList.add(con);
        }
        
        contactMainTriggerHandler.updateParentAccount(conList);
        for(Contact con : conList){
        System.assertEquals(acc.Id,con.AccountId);
        }
    }
}