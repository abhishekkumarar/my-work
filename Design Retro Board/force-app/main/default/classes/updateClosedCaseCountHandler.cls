public class updateClosedCaseCountHandler {
    public static void handleCount(List<Case> caseList) {
        Set<Id> accIds = new Set<Id>();
        if(!caseList.isEmpty()){
            for(Case ca : caseList){
                if(ca.AccountId !=null){
                    accIds.add(ca.AccountId);
                }
            }
        }
    if(!accIds.isEmpty()){
        List<Account> accList = [Select Id, Rating, (Select Id from Cases where Case_Status__c =: 'Closed' ) 
        from Account where Id =: accIds];
        List<Account> accToUpdate = new List<Account>();
        
       
            for(Account ac : accList){
                if(ac.Cases.size() >= 1 && ac.Cases.size() < 5){
                    ac.Rating='Warm';
                    accToUpdate.add(ac);
                }
                else if(ac.Cases.size() >= 5 && ac.Cases.size() < 10){
                    ac.Rating='Hot';
                    accToUpdate.add(ac);
                }
                else{
                    ac.Rating='Cold';
                    accToUpdate.add(ac);
                }
            }

        if(!accToUpdate.isEmpty()){
            update accToUpdate;
        }
    }
    }
}