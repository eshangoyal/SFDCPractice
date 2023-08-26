public with sharing class shoppingListController {
@AuraEnabled(cacheable=true)
public static List<Shopping__c> fetchShoppingRecords(){
    return [Select Id, Item__c from Shopping__c WHERE OwnerId=:UserInfo.getUserId()];
}
}
