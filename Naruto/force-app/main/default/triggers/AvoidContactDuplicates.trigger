trigger AvoidContactDuplicates on Contact (before insert, before update,after undelete) {

// This trigger will avoid duplicates on before insert and before update based on First Name of a Contact
// This trigger will work to avoid undelete of duplicate records from recycle bin

    Set<String> newFirstNameSet=new Set<String>();                                          // this we will fetch from new records
    Set<String> existingFirstNameSet=new Set<String>();                                    //this we will fetchh from existing records through SOQL
   
    // Iterating new Contact records and adding new first names to newFirstNameSet Set
    for (Contact c:Trigger.new){
        if(c.FirstName!=null){
        newFirstNameSet.add(c.FirstName);
        }
    }

    List<Contact> existingContactList=[Select Id, FirstName from Contact where FirstName IN:newFirstNameSet];   //Simple SOQL to fetch existing Contact records with Duplicate records

    
    // Iterating existing Contact records and adding existing first names to existingFirstNameSet Set
    for(Contact c:existingContactList){
        existingFirstNameSet.add(c.FirstName);
    }

    // Iterating existing Contact records and checking if there are any Duplicates
    for (Contact c:Trigger.new){
        if(existingFirstNameSet.contains(c.FirstName)){
            c.FirstName.AddError('Duplicate First Name');
        }
        else {
            existingFirstNameSet.add(c.FirstName); //this will help in bulkification as we may add two duplicate records together with one insert
        }
    }

}