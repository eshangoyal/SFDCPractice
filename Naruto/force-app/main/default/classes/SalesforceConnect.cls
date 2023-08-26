public with sharing class SalesforceConnect {
    
    public static void getCasesbyIntegrationOrg1(){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:SalesforceB/services/apexrest/Cases');
        request.setMethod('GET');
        
        HttpResponse response = http.send(request);
        // If the request is successful, parse the JSON response.
        System.debug(response.getStatusCode());
        if (response.getStatusCode() == 200) {
            System.debug(response.getBody());
        }
    }
    
}