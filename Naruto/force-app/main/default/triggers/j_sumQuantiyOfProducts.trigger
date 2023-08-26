/*A salesforce company named ABC and plan to launch a product in different region (ASIA, EMEA, NA, SA) across the globe.They also want to sell the products to their clients which are 
* in ASIA,EMEA, NA and SA .

From Admin point of view this particular scenario need to be logged into CRM for:
Create a Multi picklist name In Account Object “Working in”
Picklist Values:
1. ASIA
2. EMEA
3. NA
4. SA

(I) Write a script to get the total Quantity of Products(TotalOpportunityQuantity) sold in only Accounts Working in = ASIA.

(II) Write a Trigger to stop creating or updating Opportunities with Account having “Working in = ASIA” and Already 2 Closed Won Opportunity under same Account.
*/
trigger j_sumQuantiyOfProducts on Account (after insert) {
   //refer j_QuantityOfProducts
    
}