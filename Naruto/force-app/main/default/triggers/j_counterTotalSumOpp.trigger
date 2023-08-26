trigger j_counterTotalSumOpp on Opportunity (after insert, after update, after delete, after undelete) {
    Set<Id> accountIds = new Set<Id>();
     if(Trigger.isInsert || Trigger.isUndelete || Trigger.isUpdate){
         for(Opportunity o:Trigger.new){
             accountIds.add(o.AccountId);
         }
     }
     if(Trigger.isDelete){
         for(Opportunity o:Trigger.old){
             accountIds.add(o.AccountId);
         }
     }
     
    List<Account> accountsToBeUpdate = new List<Account>();
     
     for(AggregateResult result : [Select AccountId, SUM(Amount) sumAmount from Opportunity where AccountId=: accountIds GROUP BY AccountId]){
         Id AccountId = (Id)result.get('AccountId');
         Decimal sumAmount = (Decimal)result.get('sumAmount');
         
         Account a = new Account(Id= AccountId, TotalSum__c= sumAmount);
         accountsToBeUpdate.add(a);
     }
     if(!accountsToBeUpdate.isEmpty()){
         insert accountsToBeUpdate;
     }
 }
 