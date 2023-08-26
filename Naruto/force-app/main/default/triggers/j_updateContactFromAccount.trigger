//Update contact last name when account type = prospect
trigger j_updateContactFromAccount on Account (after update) {
    Set<Id> accountIdSet = new Set<Id>();
    for(Account a:Trigger.new){
        accountIdSet.add(a.Id);
    }
	List<Account> aList = [Select Id, Name, Type, (Select Id, Name from Contacts) from Account where Type = 'Prospect' AND Id IN:accountIdSet];
    Integer counter = 0;
    
    System.debug('aList'+aList);
    Contact[] conToBeUpdated = new Contact[]{};
        
    for(Account a:aList){
        for(Contact c:a.contacts){
            c.lastName = a.Name + counter;
            counter++;
            conToBeUpdated.add(c);
        }
    }
    System.debug('conToBeUpdated'+conToBeUpdated);
    upsert conToBeUpdated;
}