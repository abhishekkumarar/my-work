@isTest
public with sharing class opportunityTriggerHandlerTest {
    @isTest public static void updateAccount() {
        List<Opportunity> opList = new List<Opportunity>();
        List<Account> acList = new List<Account>();
        Account ac = new Account(NAme = 'Test 1');
        acList.add(ac);
        insert acList;

        for(Account acc : acList){
            Opportunity op = new Opportunity();
            op.Amount = 2000;
            op.AccountId = acc.Id;
            op.Name = 'Test';
            op.CloseDate = Date.newInstance(2024,04,01);
            op.StageName = 'Prospecting';
            opList.add(op);
        }

        insert opList;

        Account accc = [select Id, Latest_Opp_Amount__c from Account where Id=:acList[0].Id];
        for(opportunity opp : opList){
            System.assertEquals(opp.Amount, accc.Latest_Opp_Amount__c);
        }
    }
}