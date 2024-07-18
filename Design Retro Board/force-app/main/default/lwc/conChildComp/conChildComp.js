import { LightningElement,wire,track, api } from 'lwc';
import getContacts from '@salesforce/apex/getContactsForAccount.getContacts';

export default class ConChildComp extends LightningElement {
    @api accountId;
    //searchTerm='';
    contacts=[];
    //fliterContact=[];

    @wire(getContacts,{accountId:'$accountId'})
    wiredContacts({error, data}){
        if (data) {
            this.contacts = data;
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.contacts = [];
        }
    }

   /* handleConChange(event){
        this.searchTerm = event.target.value.toLowerCase();
       // this.applyFilter();
    }

    applyFilter(){
        this.fliterContact = this.allContact.filter(contact => 
            contact.FirstName.toLowerCase().includes(this.searchTerm) || 
            contact.LastName.toLowerCase().includes(this.searchTerm))
    }*/
}