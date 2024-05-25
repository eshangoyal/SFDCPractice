//Insert Contact when new account is created
//When ever the Account is created with Industry as Banking then create a contact for account, Contact Lastname as Account name and contact phone as account phone.
//Create n number of Contacts = input of NumberofLocations
trigger j_createRelatedContact on Account (after insert,after update) {
    if(Trigger.isAfter ){
        if(Trigger.isInsert || Trigger.isUpdate){
            List<Contact> cList = new List<Contact>();
            
            for(Account a:Trigger.new){
                if(a.Industry!=null){
                    if(a.Industry=='Banking' && Trigger.oldMap.get(a.Id).Industry!='Banking'){
                        for(Integer i=0;i<a.NumberofLocations__c;i++){
                            Contact cObj = new Contact(
                                FirstName = 'Contact#'+i,
                                LastName = 'LastName#'+i,
                                Phone = a.Phone,
                                AccountId = a.Id
                            );
                            cList.add(cObj);
                        }
                    }
                }
            }
            if(cList.size()>0){
                insert cList;
            }
        }
    }
}