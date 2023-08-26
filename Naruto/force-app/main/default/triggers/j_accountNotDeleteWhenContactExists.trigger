//Prevent account deletion when there is any related contact exists
trigger j_accountNotDeleteWhenContactExists on Account (before delete) {
    if(Trigger.isBefore){
        if(Trigger.isDelete){
            Set<Id> accountIdSet =new Set<Id>();
            
            for(Account a:Trigger.old){
                accountIdSet.add(a.Id);
            }
            
            Map<Id,Account> accMap = new Map<Id,Account>([Select Id,(Select Id from Contacts) from Account where id in:accountIdSet]);
            
            for(Account a:Trigger.old){
                if(accMap.get(a.Id).contacts.size()>0){
                    a.adderror('Account cannot be deleted');
                }
            }
            
        }
    }
}