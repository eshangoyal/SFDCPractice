//Write a trigger on Account , when an account insert , automatically account billing address should populate into the account shipping address.
trigger j_autoPopulateShipping on Account (after insert){
if(Trigger.isAfter && Trigger.isInsert){
        List<Account> accRecord= [Select Id,BillingCity,BillingState,BillingPostalCode,BillingCountry,ShippingCity,ShippingState,ShippingPostalCode,ShippingCountry from Account where ID in:Trigger.new];
    
        for(Account aObj:accRecord){
            if(aObj.BillingCity!=null){
                aObj.ShippingCity=aObj.BillingCity;
            }
            if(aObj.BillingState!=null){
                aObj.ShippingState=aObj.BillingState;
            }
            if(aObj.BillingPostalCode!=null){
                aObj.ShippingPostalCode=aObj.BillingPostalCode;
            }
            if(aObj.BillingCountry!=null){
                aObj.ShippingCountry=aObj.BillingCountry;
            }
            accRecord.add(aObj);
        }
        update accRecord;
    }
}