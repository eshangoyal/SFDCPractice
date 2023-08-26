//Create a trigger and update SumOfOpportunityAmmount, and in this we will have sum of all the Amount in the opportunies which are related to an Account.

Trigger j_sumAmountOnParentFromChild on Child__c(after insert, after update){
    if(Trigger.isAfter){
        if(Trigger.isInsert || Trigger.isUpdate){
    
            Set<Id> parentIdSet = new Set<Id>();
            
            for(Child__c c:Trigger.new){
                 parentIdSet.add(c.parent__c);
            }
            List<Child__c> cList = [Select Id, ChildName__c, ChildAmount__c,Parent__c from Child__c WHERE Parent__c IN:parentIdSet];
            Map<Id,List<Child__c>> childtoParentMap = new Map<Id,List<Child__c>>();
            
            for(Child__c c:cList){
                if(!childtoParentMap.containskey(c.Parent__c)){
                    childtoParentMap.put(c.Parent__c,new List<Child__c>());
                }
                childtoParentMap.get(c.Parent__c).add(c);
            }
            
            List<Parent__c> pList = [Select Id, TotalSum__c from Parent__c where Id IN:parentIdSet];
            for(Parent__c p:pList){
                List<Child__c> cObjList = new List<Child__c>();
				 cObjList =     childtoParentMap.get(p.Id);
                Double sumTotal=0;
                for(Child__c c:cObjList){
                    if(c.ChildAmount__c!=null){
                        sumTotal+=c.ChildAmount__c;
                    }
                }
                p.TotalSum__c = sumTotal;
            }
            upsert pList;
        }
    }
}