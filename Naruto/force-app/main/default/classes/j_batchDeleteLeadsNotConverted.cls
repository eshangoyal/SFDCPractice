//Write a Batch apex class to automatically delete the Leads whose Lead Status is "Closed- Not Converted".

public class j_batchDeleteLeadsNotConverted implements Database.batchable <sObject>{

	public Database.QueryLocator start(Database.batchableContext bc){
		String query = 'Select Id, Name, Status from Lead where Status = \'Closed - Not Converted\'';
		return Database.getQueryLocator(query);
	}

	public void execute(Database.batchableContext bc, List<Lead> leadRecords){
		Delete leadRecords;		
		Database.emptyRecyclebin(leadRecords);
	}

	public void finish(Database.batchableContext bc){
		System.debug('Success!');		
	}

}