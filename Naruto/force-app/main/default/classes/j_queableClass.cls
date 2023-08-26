public class j_queableClass implements Queueable {
    public void execute(QueueableContext q){
        Parent__c a = new Parent__c(
        Name = 'created From Queue'
        );
        insert a;
        
//Job chaining        System.enqueueJob(new Job2);
    }
}

//j_queableClass c =new j_queableClass();
//ID queueTest = System.enqueueJob(c);
//
//