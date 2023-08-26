//Count Contacts and update the field on Account 
//update custom field: Number_Of_Contacts__c
//update Total Sum of Account = Sum of All Phone Number from related Contacts
trigger j_countContacts on Contact (after insert, after delete, after update, after undelete) {

if(Trigger.isAfter){
    if(Trigger.isInsert || Trigger.isDelete || Trigger.isUndelete || Trigger.isUpdate){
        Set<Id> aSet = new Set<Id>();
        
        for(Contact c:Trigger.new){
            if(c.AccountId!=null){
                aSet.add(c.AccountId);
            }
        }
        if(Trigger.old!=null){

            for(Contact c:Trigger.old){
                if(c.AccountId!=null){
                    aSet.add(c.AccountId);
                }
            }
            
        }
        List<Account> aList= [Select Id, Number_Of_Contacts__c,TotalSum__c, Name,(Select Id, Amount__c, Name from Contacts) from Account where Id IN: aSet];
        
        List<Account> aToBeUpdated = new List<Account>();
        for(Account a:aList){
                a.Number_Of_Contacts__c = a.Contacts.size();
                Decimal TotalSum = 0;
                if(a.Contacts!= null ){
                    for(Contact c: a.Contacts){
                        if(c.Amount__c!=null){

                            TotalSum+=c.Amount__c;
                        }
                    }
                    a.TotalSum__c = TotalSum;
                    aToBeUpdated.add(a);
    
                }
            }
            
        
        upsert aToBeUpdated;
        
    }
}
}