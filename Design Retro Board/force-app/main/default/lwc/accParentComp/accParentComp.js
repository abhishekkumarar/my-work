import { LightningElement,wire } from 'lwc';
import getAccounts from '@salesforce/apex/getAccountForParent.getAccounts';
export default class AccParentComp extends LightningElement {
    selectedAccountId='';
    picklistOptions = [];

@wire(getAccounts)
wiredAccount({error,data}){
    if(data){
        this.picklistOptions = data.map(account =>({
            label: account.Name,
            value: account.Id}));
    } else if(error){

    }
}


handleSelection(event){
    this.selectedAccountId = event.detail.value;
}
    
}