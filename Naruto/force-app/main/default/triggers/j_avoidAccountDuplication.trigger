// This trigger will avoid duplicates on before insert and before update based on Name of account
// This trigger will work to avoid undelete of duplicate records from recycle bin
trigger j_avoidAccountDuplication on Account (before insert,before update,after delete) {
    
    Set<String> newAccountNames = new Set<String>();
    Set<String> existingAccountNames = new Set<String>();
    
    for(Account a:Trigger.new){
        newAccountNames.add(a.Name);
    }
    
    List<Account> duplicateAccounts = [Select Id,Name from Account where Name IN:newAccountNames];
    
    for(Account ac:duplicateAccounts){
        existingAccountNames.add(ac.name);
    }
    
    if(existingAccountNames.size()>0){
        for(Account a:Trigger.new){
            if(existingAccountNames.contains(a.Name)){
                a.Name.adderror('DuplicateAccount!!!');
            }
            else 
                existingAccountNames.add(a.Name);
        }   
    }
    
    
}