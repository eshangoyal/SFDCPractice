trigger sendEmailAfterInsert on Contact (after insert, after update) {

List<Messaging.Email> emailList= new List<Messaging.Email>();
EmailTemplate emailTemplate = [Select Id,Subject,Description,HtmlValue,DeveloperName,Body from EmailTemplate where name='Quote Email'];


if(Trigger.isAfter && Trigger.isInsert || Trigger.isAfter && Trigger.isUpdate){
    for(Contact conObj:Trigger.new){
    if (conObj.Email != null) {
        System.debug('line10');
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setTargetObjectId(conObj.Id);
        mail.setSenderDisplayName('System Administrator');
        mail.setUseSignature(false);
        mail.setBccSender(false);                                                                                                                                                                                                                     
        mail.setSaveAsActivity(false);
        mail.setTemplateID(emailTemplate.Id);
        mail.toAddresses = new String[]{conObj.Email};
        emailList.add(mail);
    }
    }

if(emailList.size()>0){
    System.debug('emaiLList::::'+emailList);
Messaging.SendEmailResult[] results = Messaging.sendEmail(emailList);

if (results[0].success){
System.debug('The email was sent successfully.');
} else {
System.debug('The email failed to send: '+ results[0].errors[0].message);
}
}
}

}