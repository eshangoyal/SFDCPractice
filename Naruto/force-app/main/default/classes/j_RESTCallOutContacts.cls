public class j_RESTCallOutContacts {
    
    public static void getContactsFromB(){
        
        Http http = new Http();
        
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:SalesforceB/services/apexrest/contacts');
        request.setMethod('GET');  
        
        HttpResponse response = http.send(request);
        if(response.getStatusCode()==200){
            List<Object> results = (List<Object>)JSON.deserializeUntyped(response.getBody());
            for(Object o:results){
                Map<String, Object> contactsMap=(Map<String, Object>) o; 
                
                System.debug('contact Name :'+contactsMap.get('Name')+'LeadSource:'+contactsMap.get('LeadSource'));
            }
        }
        else{
            System.debug('error');
        }
    }
    
    public static void createContactFromA(){
        Http http = new Http();
        
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:SalesforceB/services/apexrest/contacts');
        request.setMethod('POST');  
        request.setBody('{"lastName":"contactFromA","leadSource":"Web"}');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        HttpResponse response = http.send(request);
        System.debug('responseCode'+response.getStatusCode());
        
        if(response.getStatusCode()==200){
            System.debug('data from Org B::::::'+response.getBody());
        }
    }
    
}