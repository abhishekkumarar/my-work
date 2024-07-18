public with sharing class salaryTrigHelper {
    public static void updateSalary(List<Employee__c> empList, Map<Id,Employee__c> oldMap) {
        Set<Id> empIds = new Set<Id>();

        if(!empList.isEmpty()){
            for(Employee__c emp : empList){
                if(!oldMap.isEmpty()){
                    if(oldMap.get(emp.Id).Tech_Firm__c != emp.Tech_Firm__c){
                        empIds.add(emp.Tech_Firm__c);
                        empIds.add(oldMap.get(emp.Id).Tech_Firm__c);
                    }
                    else {
                        empIds.add(emp.Tech_Firm__c);
                    }
                }
                else{
                    empIds.add(emp.Tech_Firm__c);
                }
            }
        }

        list<AggregateResult> aggList =[Select Tech_Firm__c tcId, max(Salary__c) maxSalary, min(Salary__c) minSalary from Employee__c
        where Tech_Firm__c IN : empIds group by Tech_Firm__c];

        Map<Id,Tech_Firm__c> tfMap = new Map<Id, Tech_Firm__c>();

        for(Id ids : empIds){
            Tech_Firm__c tf = new Tech_Firm__c;
            tf.Id = ids;
            tf.maxSalary=0;
            tf.minSalary=0;

            tfMap.put(tf.Id,tf);
        }
        if(!aggList.isEmpty()){
            for(AggregateResult agg : aggList){
                Tech_Firm__c tf = new Tech_Firm__c;
                tf.Id = (Id)agg.get(tcId);
                tf.maxSalary = (Decimal)agg.get(maxSalary);
                tf.minSalary = (Decimal)agg.get(minSalary);

                tfMap.put(tf.Id,tf);

            }
        }

        if(!tfMap.isEmpty()){
            update tfMap.values();
        }
    }
}