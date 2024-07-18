// Calculate sum of all Opp amount and add it to total amount on accounts.
trigger sumOfOppAmount on Opportunity (after insert, after update, after delete, after undelete) 
{
    Set<Id> accIds = new Set<Id>();

    if(trigger.isAfter && (trigger.isInsert || trigger.isUndelete)){
        if(!trigger.new.isEmpty()){
            for(Opportunity op : trigger.new){
                accIds.add(op.AccountId);
            }
        }
    }

    if(trigger.isAfter && trigger.isUpdate){
        for(Opportunity op : trigger.new){
            if(op.AccountId != trigger.oldMap.get(op.Id).AccountId){
                accIds.add(op.AccountId);
                accIds.add(trigger.oldMap.get(op.Id).AccountId);
            }
            else{
                accIds.add(op.AccountId);
            }
        }
    }

    if(trigger.isAfter && trigger.isDelete){
        if(!trigger.old.isEmpty()){
            for(Opportunity op : trigger.old){
                if(op.AccountId != null){
                accIds.add(op.AccountId);}
            }
        }
    }
    System.debug(accIds);

    List<AggregateResult> aggList = [Select AccountId ids, sum(Amount) totalAmt from Opportunity 
    where AccountId IN : accIds GROUP BY AccountId ];
    Map<Id,Account> accToUpdate = new Map<Id,Account>();

    if(!aggList.isEmpty()){
        for(AggregateResult ag : aggList){
            Account ac = new Account();
            ac.Id = (Id)ag.get('ids');
            ac.Total_Amount__c = (Decimal)ag.get('totalAmt');
            accToUpdate.put(ac.Id,ac);
        }
    }

    if(!accToUpdate.isEmpty()){
        update accToUpdate.values();
    }
}