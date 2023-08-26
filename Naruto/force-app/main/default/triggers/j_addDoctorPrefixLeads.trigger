//The following trigger describes when the leads are inserted into the database it 
//would add Doctor prefixed for all lead names. This is applicable for both inserting and updating the lead records.

trigger j_addDoctorPrefixLeads on Lead (before insert, before update) {
    if(Trigger.isBefore){
        if(Trigger.isInsert || Trigger.isUpdate){
            for(Lead l:Trigger.new){
                l.Salutation = 'Dr.';
            }
        }
    }
}