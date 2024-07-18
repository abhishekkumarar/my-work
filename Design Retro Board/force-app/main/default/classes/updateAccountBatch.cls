global class updateAccountBatch implements Database.Batchable<sObject> {
    global Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator('select Id, Industry from Account where Industry = null');
    }
    
    global void execute(Database.BatchableContext bc, List<sObject> accList){
        List<Account> acList = (List<Account>)accList;
        for(Account acc : acList){
            acc.Industry = 'Software';
        }
        update acList;
    }
    
    global void finish(Database.BatchableContext bc){

    }
}