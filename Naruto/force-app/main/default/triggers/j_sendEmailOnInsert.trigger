trigger j_sendEmailOnInsert on Child__c (before insert) {
        for(Child__c c: Trigger.new){
            
         Messaging.SingleEmailMessage mail = new  Messaging.SingleEmailMessage();
        String[] toAddress = new String[]{'eshangoyal2000@gmail.com'};
            mail.setToAddresses(toAddress);
            mail.setSubject('child has been created successfully');
            mail.setPlainTextBody(
                'Hi, it is a confirmation mail for child creation');
            Messaging.sendEmail(new Messaging.SingleEmailMessage[]{mail});
        }
}