import { LightningElement, track } from 'lwc';

export default class SearchAccountChild extends LightningElement {

    @track searchTerm;

    handleInputChange(event){
        this.searchTerm = event.target.value;
        const msgEvent = new CustomEvent('searchterm',{detail: this.searchTerm});
        this.dispatchEvent(msgEvent);
    }
}