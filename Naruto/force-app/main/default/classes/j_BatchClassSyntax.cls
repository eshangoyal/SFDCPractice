global class j_BatchClassSyntax implements Database.Batchable<sObject> {
	
    public static Database.QueryLocator start(Database.BatchableContext bc){
       String query ='select Id,phone from Account limit 100';
        
        System.debug('in start');
        return Database.getQueryLocator(query);
    }
    
    public void execute(Database.BatchableContext bc, List<Account> acc){
        Account[] aList = new Account[]{};
        for(Account a:acc){
            if(a.phone!= null){
                a.phone = '9999';
                aList.add(a);
            }
        }
        upsert aList;
        System.debug('in execute');
    }
    
    public void finish(Database.BatchableContext bc){
        System.debug('BATCH DONE SUCCESSFULLY');
    }
}