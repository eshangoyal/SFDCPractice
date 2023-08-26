//deactive those users whose lastlogin >30 days from today
public class j_Batch_deactiveUsersLastLogin implements Database.Batchable <sObject> {

	public Database.queryLocator start(Database.batchableContext bc){
        //Select Id, Name, LastLoginDate, isActive from User where LastLoginDate < n_days:30'
		String query = 'Select Id, Name, LastLoginDate, isActive from User';
		return Database.getQueryLocator(query);
	}

	public void execute(Database.batchableContext bc, List<User> userList){
		List<User> uList = new List<User>();
		for(User u:userList){
		if(u.LastLoginDate<System.today().addDays(-30)){
			u.isActive = false;
			uList.add(u);
			}
		}
        System.debug('uList:::::'+uList);
		if(userList.size()>0){
		update uList;
		}
	}

	public void finish(Database.batchableContext bc){
	System.debug('Your batch job has been completed!');
	}
	
}