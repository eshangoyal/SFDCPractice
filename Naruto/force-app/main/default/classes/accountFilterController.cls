public with sharing class accountFilterController {

@AuraEnabled(cacheable=true)
public static List<Account> filterAccount(String keySearch, String countryCode, String stateCode){
String searchKeyword = '%'+keySearch+'%'; 
System.debug('keySearch--->'+keySearch);
System.debug('countryCode--->'+countryCode);
System.debug('stateCode--->'+stateCode);


if(stateCode==null){
    stateCode='';
    
System.debug('stateCode222--->'+stateCode);
}
List<Account> aList = new List<Account>();
if(keySearch == '' && countryCode =='' && stateCode == ''){
    System.debug('line#11');
        aList = [Select Id, Name,website,OwnerId,AnnualRevenue,NumberOfEmployees From Account LIMIT 5]; 
}
else if(keySearch!='' && countryCode =='' && stateCode == '' ){
    System.debug('line#15');
    aList = [Select Id, Name,website,OwnerId,AnnualRevenue,NumberOfEmployees From Account WHERE Name LIKE :searchKeyword LIMIT 10];
}

else if(countryCode!='' && stateCode == ''){
    System.debug('line#20');
    aList = [Select Id, Name,website,OwnerId,AnnualRevenue,NumberOfEmployees,BillingCountryCode From Account WHERE BillingCountryCode = :countryCode LIMIT 10];
    System.debug('aList'+aList);
}
else if(countryCode!='' && stateCode!=''){
    System.debug('line#24');
    aList = [Select Id, Name,website,OwnerId,AnnualRevenue,NumberOfEmployees,BillingStateCode,BillingCountryCode From Account WHERE BillingCountryCode = :countryCode AND BillingStateCode = :stateCode LIMIT 10];
}
return aList;
}

}