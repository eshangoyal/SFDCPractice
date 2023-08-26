// Update Accout Name with Contact Name when LeadSource = Other on insert and when changes from web to other on update
trigger j_updateAccountFromContact on Contact (after insert, after update) {
    if(Trigger.isAfter){
        if(Trigger.isInsert){
            Set<Id> AccountIdSet = new Set<Id>();
            for(Contact c:Trigger.new){
                AccountIdSet.add(c.AccountId);
            }
            List<Contact> cList = [Select Id,LeadSource,AccountId,LastName from Contact where LeadSource = 'Other' AND accountId IN:AccountIdSet];
            Map<Id,Account> aList = new Map<Id,Account>([Select Id, Name from Account where Id IN:AccountIdSet]);
            Account[] accToUpdate = new Account[]{};  
                
                for(Contact c:cList){
                    if(c.AccountId!=null && c.AccountId == aList.get(c.AccountId).Id){
                        Account aObj = new Account(
                            Name = c.LastName,
                            Id = aList.get(c.AccountId).Id
                        );
                        accToUpdate.add(aObj);
                    }
                }
            upsert accToUpdate;
        }
        
    }
}