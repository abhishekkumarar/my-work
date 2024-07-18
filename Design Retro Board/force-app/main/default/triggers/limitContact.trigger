trigger limitContact on Contact (before insert, before update) {
    Set<Id> accIds = new Set<Id>();

    if(trigger.isBefore && (trigger.isInsert || trigger.isUpdate)){
        if(!trigger.new.isEmpty()){
            for(Contact con : trigger.new){
                if(con.AccountId != null){
                    accIds.add(con.AccountId);
                }
            }
        }
    }

    Map<Id,Integer> countMap = new Map<Id,Integer>();

    List<AggregateResult> aggList = [Select AccountId, count(Id) conCount from Contact where AccountId IN : accIds 
    GROUP BY AccountId];
    if(!aggList.isEmpty()){
        for(AggregateResult ag : aggList){
            countMap.put((Id)ag.get('AccountId'), (Integer)ag.get('conCount'));
        }
    }

    if(!trigger.new.isEmpty()){
        for(Contact c: trigger.new){
            if(c.AccountId != null && countMap.get(c.AccountId) >=2){
                c.addError('Only 2 contacts allowed on an Account');
            }
        }
    }
}