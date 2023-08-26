// Two fields, Status on child__c object which is a checkbox, child_status__c picklist field on Opportunity.
// Whenever a child record is created with checkbox TRUE, update opportunity's picklist as 'Active'.
trigger j_autoPopulateChildStatusOnOpportunity on Child__c (after insert, after update) {
    List<Opportunity> opps=new List<Opportunity>();
    for(Child__c cp:Trigger.New){
        if(cp.Status__c==True){
            Opportunity opp= new Opportunity(
                id=cp.Opportunity__c,
                child_status__c = 'Active'
            );
            opps.add(opp);
        }
    }
    update opps;
}