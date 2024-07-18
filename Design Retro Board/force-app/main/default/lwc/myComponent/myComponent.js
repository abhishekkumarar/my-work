import { LightningElement, wire } from 'lwc';
import getAccounts from '@salesforce/apex/myCompHandler.getAccounts';
const columns = [
    {label: 'Account Name', fieldName: 'Name', type: 'text'},
    {label: 'Email', fieldName: 'Email__c', type: 'text'}
]

export default class MyComponent extends LightningElement {
    accounts;
    error;

    @wire(getAccounts)
    wiredAccounts({error, data}){
        if(data){
            this.accounts = data;
            this.error = undefined;
        }
        else if(error){
            this.error = error;
            this.data = undefined;
        }
    }

    get columns(){
        return columns;
    }
}