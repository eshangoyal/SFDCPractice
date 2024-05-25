//Two fields, Status on child__c object which is a checkbox, child_status__c picklist field on Opportunity. 
//Whenever a child record is created with checkbox TRUE, update opportunity's picklist as 'Active'.

Trigger updateCheck on Child__c(after insert){


set<Id> oppSet = set<Id>();
for(Child__c c:trigger.new){
    if(c.child_status__c == true){
        oppSet.add(c.OpportunityId)
    }
}
List<Opportunity> oppToBeUpdated = new List<Opportunity>();
List<Opportunity> oList = [Select Id from Opportuinty where Id IN: oppSet];

for(Opportunity o:oList){
  o.Staus = 'Active';
  oppToBeUpdated.add(o);
}


    update oppToBeUpdated;
}
