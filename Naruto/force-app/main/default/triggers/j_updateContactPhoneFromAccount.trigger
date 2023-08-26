//Whenever Account's phone is modified, update contact's phone field:
//contact's otherphone = oldvalue
//homephone = new value 


trigger j_updateContactPhoneFromAccount on Account (after update) {
    if(Trigger.isAfter){
        if(Trigger.isUpdate){
            List<Contact> cList = new List<Contact>();
            
            
            List<Account> aList = [Select Id, Name, Phone,(Select Id,OtherPhone,HomePhone from Contacts) from Account where Id IN: Trigger.newmap.keySet()];
            
            for(Account a:aList){
                if(Trigger.oldMap.get(a.Id).Phone!=null && a.Phone!= Trigger.oldMap.get(a.Id).Phone){
                    for(Contact c:a.Contacts){
                        c.OtherPhone = Trigger.oldMap.get(a.Id).Phone;
                        c.HomePhone = a.Phone;
                        cList.add(c);
                    }
                    update cList;
                }
            }
        }
    }
}