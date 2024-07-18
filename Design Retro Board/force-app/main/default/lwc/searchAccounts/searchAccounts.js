import { LightningElement, wire, track } from 'lwc';
import searchAcct from '@salesforce/apex/searchAccountsHandler.searchAcct';

export default class SearchAccounts extends LightningElement {

    @track searchTerm = '';
    @track accounts;
    @track error;


    handleSearchTerm(event){
        this.searchTerm = event.detail;
    }

    @wire(searchAcct, {searchTerm: '$searchTerm'})
    wiredAccounts({error, data}){
        if(data){
            this.accounts = data;
            this.error = undefined;
        }else if(error){
            this.error = error;
            this.data = undefined;
        }
    }
}