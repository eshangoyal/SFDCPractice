/*Write a trigger on the Account when the Account is updated check all opportunities related to the account. 
Update all Opportunities Stage to close lost 
if an opportunity created date is lesser than 30 days from today and stage not equal to close won.
DateTime day30=system.now()-30;
*/

trigger j_updateOpportunity on Account (after update) {
    if(Trigger.isAfter && Trigger.isUpdate){
        List<Opportunity> oppToBeUpdated = new List<Opportunity>();
        Set<Id> accountIds = new Set<Id>();
        DateTime day30=system.now()-30;
        
        for(Account a:Trigger.new){
            accountIds.add(a.Id);
        }
        
        List<Opportunity> oList = [SELECT Id, StageName, CreatedDate from Opportunity where AccountId IN: accountIds];
        for(Opportunity o:oList){
            if(o.CreatedDate < day30 && o.StageName!= 'Close Won'){
                o.StageName = 'Close Lost';
            }
            oppToBeUpdated.add(o);
        }
        if(oppToBeUpdated.size()>0){
            update oppToBeUpdated;
        }
    }
}