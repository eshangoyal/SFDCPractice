//whenever new account is create new opportunty and contact should be created
trigger j_autoPopulateOpportunity on Account (after insert, before update) {
    if(Trigger.isBefore || Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate)){
        List<Contact> contactsToBeInserted = new List<Contact>();
        List<Opportunity> opportunityToBeInserted = new List<Opportunity>();
        
        for(Account a:Trigger.new){
            Contact cObj = new Contact(
                LastName = a.Name,
                accountId = a.Id 
            );
            contactsToBeInserted.add(cObj);
            
            Opportunity oppObj = new Opportunity();
            oppObj.Name =a.Name;
            oppObj.StageName = 'Qualification';
            oppObj.CloseDate = System.today();
            oppObj.AccountId = a.Id;
            opportunityToBeInserted.add(oppObj);
        }
        if(contactsToBeInserted.size()>0){
            System.debug('22');
            insert contactsToBeInserted;
        }     
        if(contactsToBeInserted.size()>0){
            insert opportunityToBeInserted;
            
        }
    } 
}