public class basicLWCController {
   
    @AuraEnabled(cacheable=true)
    public static list<Contact> getContacts(String recordId){
        return [Select Id, Name from Contact where Id= :recordId];
    }
    
    @AuraEnabled(cacheable=true)
    public static list<Contact> getAccounts(){
        return [Select Id, Name from Contact where ownerId= :UserInfo.getUserId() LIMIT 10];
    }
    
    
    @AuraEnabled
    public static void deleteAccountById(String accountId){
        Account acc = [Select Id from Account where Id= :accountId];
        Database.delete(acc);
    }
}