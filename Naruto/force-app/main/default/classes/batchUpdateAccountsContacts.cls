//Update account description, number of employees, contact last name using batch apex. Get the failure record ids in the email. Also, schedule the job for every Monday.
//Update account description, number of employees, contact last name using batch apex. Get the failure record ids in the email. Also, schedule the job for every Monday.


global class batchUpdateAccountsContacts implements Database.batchable <sObject>, Database.Stateful,Schedulable{
    
    Set<Id> failRecordsIdSet = new Set<Id>();
    Set<Id> successRecordsIdSet = new Set<Id>();
    global Database.QueryLocator start(Database.BatchableContext bc){
        String query = 'Select Id, Name, Description, NumberOfEmployees,(Select Id, LastName from Contacts) FROM Account Where Name =\'newTask#4\'';
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext bc, List<Account> accRececords){
        
        Account[] aList = new Account[]{};
            Contact[] cList = new Contact[]{};
                
                for(Account a:accRececords){
                    a.Description = 'updated from batch';
                    a.NumberOfEmployees = 40;
                    aList.add(a);
                    for(Contact c:a.Contacts){
                        c.LastName = 'LastName updated from Batch';
                        cList.add(c);
                    }
                }
        Database.saveResult[] aResult = Database.update(aList, false);
        Database.saveResult[] cResult = Database.update(cList, false);
        
        for(Database.saveResult a:aResult){
            if(a.isSuccess()){
                successRecordsIdSet.add(a.Id);
            }
            else{
                for(Database.error err:a.getErrors()){
                    failRecordsIdSet.add(a.Id);
                }
            }
        }
        
        for(Database.saveResult c:cResult){
            if(c.isSuccess()){
                successRecordsIdSet.add(c.Id);
            }
            else{
                for(Database.error err:c.getErrors()){
                }
                failRecordsIdSet.add(c.Id);
            }
        }
    }
    
    global void finish(Database.BatchableContext bc){
        AsyncApexJob a = [Select Id, Status, TotalJobItems, NumberOfErrors, CreatedBy.Email from AsyncApexJob where Id = :bc.getJobId()];
        
        List<Messaging.SingleEmailMessage> emailList = new List<Messaging.SingleEmailMessage>();
        
        String[] toAdresses = new String[]{a.CreatedBy.Email};
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(toAdresses);
        mail.setSubject('Apex Batch Job Completed');
        mail.setPlainTextBody('The Batch Job has been comppleted with total'+a.TotalJobItems+'having total'+a.NumberOfErrors+'errors. And success records IDs are:'+successRecordsIdSet+'+Failed Records IDs'+failRecordsIdSet);
        emailList.add(mail);	
        Messaging.sendEmail(emailList); 
    }
    global void execute(SchedulableContext sc){
        batchUpdateAccountsContacts b= new batchUpdateAccountsContacts();
        Database.executeBatch(b,100);
        //System.schedule(‘Testing’, cronexpression, testobj);
}
}