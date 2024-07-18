public class oppLineItemHandler {
    public static void countOppLineItem(List<OpportunityLineItem> oppList) {
        Set<Id> oppId = new Set<Id>();
        Map<Id, Decimal> countMap = new Map<Id, Decimal>();
        List<Account> accToUp = new List<Account>();
        if(!oppList.IsEmpty()){
            for(OpportunityLineItem oppL : oppList){
                oppId.add(oppL.Opportunity.Id);
            }
        }

        if(!oppId.isEmpty()){
            List<Opportunity> opList = [Select Id, AccountId from Opportunity where Id In : oppId];
            for(Opportunity op : opList){
                countMap.put(op.AcountId, 0);
            }
        }

        for(AggregateResult agg : [Select count(Id) count, Opportunity.AccountId ids from OpportunityLineItem where Opportunity.AccountId
        In : countMap.keyset() group by Opportunity.AccountId]){
            countMap.put((Id) agg.get('ids'), (Decimal) agg.get('count'));
        }

        for(Id accIds : countMap.keyset()){
            Account ac = new Account();
            ac.Id = accIds;
            ac.OppLineCount__C = countMap.get(accIds);
            accToUp.add(ac);
        }

        update accToUp;
    }
}