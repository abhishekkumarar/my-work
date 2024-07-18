public class accountStatusChangeHandler {
    public static void handleStatus(List<Account> accList, Map<Id, Account> oldMap) {
        Set<Id> accIds = new Set<Id>();
        for(Account ac : accList){
            if(ac.Active__c == 'No' && ac.Active__c != oldMap.get(ac.Id).Active__c){
                accIds.add(ac.Id);
            }
        }

        Map<Id,Integer> oppCountMap = new Map<Id,Integer>();

        for(AggregateResult agg : [Select AccountId ids, count(Id) oppCount from Opportunity where AccountId =: accIds group by AccountId]){
            oppCountMap.put((Id)agg.get('ids'), (Integer)agg.get('oppCount'));
        }

        for(Account acc : accList){
            if(oppCountMap.containsKey(acc.Id) && oppCountMap.get(acc.Id) > 0){
                acc.addError('Nope');
            }
        }
    }
}