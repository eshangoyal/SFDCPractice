/*we have two fields i.e. Amount on Opportuinty and  SumOfOpportunityAmmount__c on Account
We want to show the sum of all the Amount from related Opportuinities on the SumOfOpportunityAmmount__c on Account.

Suppose we have 5 opportunies having Amount as 10,20,10,10,30.
SumOfOpportunityAmmount__c field on the parent Account will be 10+20+10+10+30 = 80.
*/
Trigger j_SumAmountOfOpportunities on Opportunity(after insert, after update, after delete, after undelete ){
    if(Trigger.isAfter){
	Set<Id> aSet = new Set<Id>();
	Account[] accountsToBeInserted = new Account[]{};
        if(Trigger.isInsert || Trigger.isUpdate || Trigger.isUndelete){
		for(Opportunity o:Trigger.new){
			aSet.add(o.AccountId);
		}
	}

	if(Trigger.isInsert){
		for(Opportunity o:Trigger.old){
			aSet.add(o.AccountId);
		}
	}
	Account[] aList =[Select Id, TotalSum__c,(Select Id, Amount from Opportunities) from Account where Id IN: aSet];

	for(Account acc:aList){
		Decimal TotalSum = 0;
        Account aObj = new Account(Id=acc.Id);
		for(Opportunity o:acc.Opportunities){
		TotalSum += (o.Amount!=null?o.Amount:0);
		}
		aObj.TotalSum__c = TotalSum;
		accountsToBeInserted.add(aObj);
	}
	if(accountsToBeInserted.size()>0){
	update accountsToBeInserted;
	}
     
    }
}