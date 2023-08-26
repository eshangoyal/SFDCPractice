public with sharing class AccountTriggerHandler {
    
    public static void CreateRelatedContact(list<Account> acc){
        List<Contact> cList = new List<Contact>();
        for (Account aObj:acc){
            Contact c = new Contact();
            c.Accountid=aObj.Id;
            c.LastName = aObj.name;
            c.phone = aobj.phone;
            cList.add(c);
        }
        insert cList;
    }
}