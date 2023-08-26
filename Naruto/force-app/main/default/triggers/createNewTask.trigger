/*update account on insert when industry old = Banking
new industry = education
and create new task
having subject=industry change
*/

Trigger  createNewTask on Account(after update){
    
   /* if(Trigger.isAfter || Trigger.isUpdate){
        List<Task> taskToBeCreated = new List<Task>();
        for(Account a:Trigger.new){
            if(a.Industry=='Education' && Trigger.OldMap.get(a.Id).Industry=='Banking'){
                Task t = new Task(
                    Subject = 'Industry Change',
                    WhatId=a.Id,
                    OwnerId=a.OwnerId
                );
                taskTobeCreated.add(t);
            }
        }
        if(taskTobeCreated.size()>0){
            upsert taskTobeCreated;
        }
    }
*/
}