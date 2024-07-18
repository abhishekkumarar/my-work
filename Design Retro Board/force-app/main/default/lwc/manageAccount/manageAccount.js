import { LightningElement, wire, api } from 'lwc';
import getAccount from '@salesforce/apex/getCurrAccount.getAccount';

export default class ManageAccount extends LightningElement {
@api recordId;

accountName;
accountEmail;

@wire (getAccount,{recordId : '$recordId'})
wiredAccounts({error,data}){
    if(data){
        this.accountName = data.Name;
        this.accountEmail = data.Email__c;
    } else if(error){
        console.log('error');
    }
}

handleNameChange(event){
    this.accountName = event.target.value;
}

handleEmailChange(event){
    this.accountEmail = event.target.value;
}

}