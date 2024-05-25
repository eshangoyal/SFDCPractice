public class countCountries(){

    public countCountryMethod(){

        for(AggregateResult r:[Select count(Id) count,Country__c country from Account WHERE COUNTRY__C!=null GROUP BY Country__c]){
            Decimal count = (Decimal).r.get('count');
            String country = (String).r.get('country');
            System.debug('Country: '+country+' Count: '+count);
        }
    }
}