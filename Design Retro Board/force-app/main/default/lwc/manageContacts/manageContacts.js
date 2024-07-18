import { LightningElement, api, wire } from 'lwc';
import getContact from '@salesforce/apex/getCurrContact.getContact';

export default class ManageContacts extends LightningElement {
    @api recordId;

    contactName;
    contactEmail;

    @wire(getContact, {recordId : '$recordId'})
    wiredContact(error, data){
        if(data){
            this.contactName = data.LastName;
            this.contactEmail = data.Email;
        }else if (error){
            console.log("error");
        }
    }

    handleNameChange(event){
        this.contactName = event.target.value;
    }

    handleEmailChange(event){
        this.contactEmail = event.target.value;
    }
}