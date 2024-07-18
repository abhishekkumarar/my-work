trigger checkDuplicate on Contact (before insert, before update) {
    Map<String, Contact> emailMap = new Map<String, Contact>();
    Map<String, Contact> phoneMap = new Map<String, Contact>();

    if(trigger.isInsert && trigger.isBefore){
        if(!trigger.new.isEmpty()){
            for(Contact c : trigger.new){
                if(c.Email != null){
                    emailMap.put(c.Email, c);
                }
                if(c.Phone != null){
                    phoneMap.put(c.Phone, C);
                }
            }
        }
    }

    if(trigger.isAfter && trigger.isUpdate){
        if(!trigger.new.isEmpty()){
            for(Contact c : trigger.new){
                if(trigger.oldMap.get(c.Id).Email != c.Email){
                    emailMap.put(c.Email, c);
                }
                if(trigger.oldMap.get(c.Id).Phone != c.Phone){
                    phoneMap.put(c.Phone, c);
                }
            }
        }
    }

    List<Contact> existCon = [select Id, Email, Phone from Contact where Email IN : emailMap.keyset() or Phone IN : phoneMap.keyset()];
    
    String errorMsg ='';

    if(!existCon.isEmpty()){
        for(Contact c : existCon){
            if(c.Email != null){
                if(emailMap.get(c.Email) != null){
                    errorMsg = 'Email';
                }
            }

            if(c.Phone != null){
                if(phoneMap.get(c.Phone) != null){
                    errorMsg = errorMsg+(errorMsg != '' ? ' and Phone' : ' Phone');
                }
            }
        }
    }

    if(!trigger.new.isEmpty()){
        for(Contact c : trigger.new){
            if(errorMsg != ''){
                c.addError('Your Contact '+ errorMsg+ ' already Exists.' );
            }
        }
    }

}