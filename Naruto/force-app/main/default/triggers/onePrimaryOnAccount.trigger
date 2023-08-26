// Write a trigger to so if we insert a contact having primary = true then all other contacts primary field will be updated to false of that particular account
trigger onePrimaryOnAccount on Contact (before insert){
    if(Trigger.isBefore && Trigger.isInsert){
        Set<Id> accountIdsSet= new Set<Id>();
        for(Contact c:Trigger.new){
            accountIdsSet.add(c.accountId);
        }
        List<Contact> contactToBeUpdated= new List<Contact>();
        for(Contact c:[SELECT Id, Primary_Contact__c from Contact where accountId IN :accountIdsSet AND Primary_Contact__c = True]){
            c.Primary_Contact__c = False;
            contactToBeUpdated.add(c);
        }
        if(contactToBeUpdated.size()>0){
            insert contactToBeUpdated;  
        }      
    }
    
}