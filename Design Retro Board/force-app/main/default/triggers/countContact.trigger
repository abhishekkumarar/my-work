trigger countContact on Contact (after insert, after update, after delete, after undelete) {
    Set<Id> accIds = new Set<Id>();

    if(trigger.isAfter && (trigger.isInsert || trigger.isUndelete)){
        if(!trigger.new.isEmpty()){
            for(Contact con : trigger.new){
                if(con.AccountId != null){
                    accIds.add(con.AccountId);
                }
            }
        }
    }

    if(trigger.isAfter && trigger.isUpdate){
        if(!trigger.new.isEmpty()){
            for(Contact con : trigger.new){
                if(con.AccountId != trigger.oldMap.get(con.Id).AccountId){
                    if(trigger.oldMap.get(con.Id).AccountId != null){
                        accIds.add(trigger.oldMap.get(con.Id).AccountId);
                    }
                    if(con.AccountId != null){
                        accIds.add(con.AccountId);
                    }
                }
            }
        }
    }

    if(trigger.isAfter && trigger.isDelete){
        if(!trigger.old.isEmpty()){
            for(Contact con : trigger.old){
                if(con.AccountId != null){
                    accIds.add(con.AccountId);
                }
            }
        }
    }

    if(!accIds.isEmpty()){
        List<Account> accUpdate = [select Id, Number_of_Contacts__c,(select Id from Contacts) from Account where Id IN : accIds ];
        List<Account> accToUpdate = new List<Account>();

        if(!accUpdate.isEmpty()){
            for(Account acc : accUpdate){
                acc.Number_of_Contacts__c = acc.Contacts.size();
                accToUpdate.add(acc);
            }
        }
        if(!accToUpdate.isEmpty()){
            update accToUpdate;
        }
    }
}