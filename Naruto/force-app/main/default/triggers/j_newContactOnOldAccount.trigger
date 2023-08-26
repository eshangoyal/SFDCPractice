//when a new contact is created for a existing account then set contact otherphone as account phone.

trigger j_newContactOnOldAccount on Contact (before insert) {
    Set<Id> accountSet = new Set<Id>();
    for(Contact c:Trigger.new){
        if(String.isNotBlank(c.AccountId)){
            accountSet.add(c.accountId);
        }
    }
    if(accountSet!=null){
        Map<Id,Account> accMap = new Map<Id,Account>([Select Id,phone from Account where Id IN: accountSet]);
        
        for(Contact c:Trigger.new){
            if(c.AccountId!=null && accMap.containskey(c.AccountId)){
                if(accMap.get(c.AccountId).Phone!=null){
                    c.OtherPhone = accMap.get(c.AccountId).Phone;
                }
            }
        }
    }    
    
}