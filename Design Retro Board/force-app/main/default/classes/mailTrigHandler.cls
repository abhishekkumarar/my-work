public with sharing class mailTrigHandler {
    public static void sendEm(List<Account> accList, Map<Id,Account> accMap) {
        Set<Id> accIds = new Set<Id>();
        if(!accList.isEmpty()){
            for(Account acc : accList){
                if(acc.Type != accMap.get(acc.Id).Type){
                    accIds.add(acc.Id);
                }
            }
        }

        List<Contact> conList = [Select Id, AccountId, Email, LastName from Contact where AccountId IN : accIds];
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();


        if(!conList.isEmpty()){
            for(Contact con : conList){
                if(con.Email != null){
                   Messaging.SingleEmailMessage mail = new  Messaging.SingleEmailMessage();
                   mail.setTargetObjectId(con.Id);
                   mail.setSenderDisplayName('System Admin');
                   mail.setSubject('Account Update Info');
                   String body = 'Dear '+ con.LastName +'<br/>';
                   body += 'Your Account type has been changed';
                   mail.setHtmlBody(body);
                   mail.toAddresses = new String[]{con.Email};
                   
                   mails.add(mail);
                }
            }
        }
        if(!mails.isEmpty()){
            Messaging.sendEmail(mails);
        }
    }
}