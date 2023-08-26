//Counter, and we want it to be increase by 1 whenever an account's name is changed.

trigger j_counterOnAccount on Account (before update) {
    if(Trigger.isBefore){
        if(Trigger.isUpdate){
            for(Account a:Trigger.new){
                if(a.Name!=Trigger.oldmap.get(a.Id).Name){
                    if(a.counter__c!=null){
                        a.counter__c++;
                    }
                }
            }
        }
    }
}