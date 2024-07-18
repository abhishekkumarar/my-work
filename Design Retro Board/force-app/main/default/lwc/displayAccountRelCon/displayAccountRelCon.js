import { LightningElement,wire } from 'lwc';
import getRelCon from '@salesforce/apex/accRelConHandler.getRelCon';
export default class DisplayAccountRelCon extends LightningElement {

    accounts;
    error;

    @wire(getRelCon)
    wiredAccounts({error,data}){
        if(data){
            this.accounts = data;
            this.error = undefined;
        }
        else if(error){
            this.error = error;
            this.data = undefined;
        }
    }
}