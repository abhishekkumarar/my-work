trigger preventDuplicateAccTrigger on Account (before insert, before update) {
    Set<String> accNames = new Set<String>();
    if(trigger.isBefore && (trigger.isInsert || trigger.isUpdate)){
    if(!trigger.new.isEmpty()){
        for( Account a : trigger.new){
            accNames.add(a.Name);
        }
    }
}
    List<Account> acc = [Select Name,Id from Account where name IN : accNames];
    Map<String,Account> accMap = new Map<String,Account>();

    if(!acc.isEmpty()){
        for(Account a : acc){
            accMap.put(a.Name,a);
        }

        if(!trigger.new.isEmpty()){
            for(Account a : trigger.new){
                if(accMap.containsKey(a.Name)){
                    a.Name.addError('The Name already exists');
                }
            }
        }
    }
}