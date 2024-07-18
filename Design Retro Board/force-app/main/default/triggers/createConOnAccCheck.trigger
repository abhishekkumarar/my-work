//Creating new contact if the check box is checked on the account obj.
trigger createConOnAccCheck on Account (after insert, after update) {
    List<Account> accList = new List<Account>();

    if(trigger.isAfter && (trigger.isInsert || trigger.isUpdate)){
        if(!trigger.new.isEmpty()){
            for(Account a : trigger.new){
                if(a.Check_Box__c == ture){
                    Contact con = new Contact();
                    con.FirstName = 'Test';
                    con.LastName = a.Name;
                    con.AccountId = a.Id;
                    con.Phone = a.Phone;
                    accList.add(con);
                }
            }
        }
    }
    if(!accList.isEmpty()){
        insert accList;
    }
}