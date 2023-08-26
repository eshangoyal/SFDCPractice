trigger j_countTotalContacts on Contact (after insert,after delete,after update) {
    
    
      set<Id> accIdSet = new set<Id>();
    
    if(Trigger.isAfter && (Trigger.isUpdate || Trigger.isInsert)){
        for(Contact c:Trigger.new){
            accIdSet.add(c.accountId);
        }
    }
    
    if(Trigger.isDelete){
        for(Contact c:Trigger.old){
            accIdSet.add(c.accountId);
        }
    }
    
    Account[] aList = [Select Id,Number_of_contacts__c from Account where Id IN: accIdSet];
    Contact[] cList = [Select Id,AccountId from Contact where AccountId IN: accIdSet];
    
   Contact[] contactListInOneAccount = new Contact[]{};
    Account[] accToBeUpdated = new Account[]{};
    
        for(Account a:aList){
            contactListInOneAccount.clear();
            for(Contact c:cList){
                if(c.AccountId == a.Id){
                    contactListInOneAccount.add(c);
                }
            }
            if(contactListInOneAccount.size()==0){
                a.Number_of_contacts__c =0;
            }
            else if(contactListInOneAccount.size()>0){
                a.Number_of_contacts__c = contactListInOneAccount.size();
            }
            accToBeUpdated.add(a);
        }
    if(accToBeUpdated.size()>0){
   upsert accToBeUpdated;
    }
}