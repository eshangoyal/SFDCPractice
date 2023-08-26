//Avoid Duplicate Emails on Leads

trigger j_avoidDuplicateEmailOnLeads on Lead (before insert,before update) {
 Set<String> newEmailList = new Set<String>();
    Set<String> existingEmailList = new Set<String>(); //existing email list which will be duplicate
    
    for(Lead a:Trigger.new){
        newEmailList.add(a.Email);
    }
    
    List<Lead> duplicateEmailLeads = [Select Id,Email from Lead where Email IN:newEmailList];
    
    for(Lead ac:duplicateEmailLeads){
        existingEmailList.add(ac.Email);
    }
    
    if(existingEmailList.size()>0){
        for(Lead a:Trigger.new){
            if(existingEmailList.contains(a.Email)){
                a.Email.adderror('Duplicate Email!!!');
            }
            else 
                existingEmailList.add(a.Email); //for bulkification
        }   
    }
}