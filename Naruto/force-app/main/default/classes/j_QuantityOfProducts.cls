/*
Create a Multi picklist name In Account Object “Working in”
Picklist Values:
1. ASIA
2. EMEA
3. NA
4. SA

(I) Write a script to get the total Quantity of Products(TotalOpportunityQuantity) sold in only Accounts Working in = ASIA.

(II) Write a Trigger to stop creating or updating Opportunities with Account having “Working in = ASIA” and Already 2 Closed Won Opportunity under same Account.
*/

public class j_QuantityOfProducts {
    public static void GetToatlProductQty(){        
        List<account> AccList = [select id,Name from Account where Working_in__c = 'ASIA'];        
        //system.debug('ACCCC'+AccList);        
        if(AccList.size()>0){            
            List<Opportunity> oppList =[select id,TotalOpportunityQuantity,AccountId from Opportunity where AccountId IN: AccList AND StageName='Closed Won'];            
            //system.debug('opp'+oppList);            
            for(Opportunity opp:oppList){                
                System.debug('ACCOUNT'+opp.AccountId+'Number Of Product Sol'+opp.TotalOpportunityQuantity);            
            }        
        }    
    } 
}