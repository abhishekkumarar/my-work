import { LightningElement } from 'lwc';
import {ShowToastEVent} from 'lightning/platformShowToastEvent';
import BOARD_OBJECT from '@salesforce/schema/Board__c';
import NAME_FIELD from '@salesforce/schema/Board__c.Name';
import DESCRIPTION_FIELD from '@salesforce/schema/Board__c.Description__c';
import NOOFSECTIONS_FIELD from '@salesforce/schema/Board__c.NoOfSections__C';
import saveBoard from '@salesforce/apex/BoardController.saveBoard';

export default class Boards extends LightningElement {

    showModalPopup=false;
    objectApiName=BOARD_OBJECT;

    nameField=NAME_FIELD;
    descriptionField=DESCRIPTION_FIELD;
    noOfSectionsField=NOOFSECTIONS_FIELD;

    sections = [];

    popupCloseHandler(){
        this.showModalPopup=false;
    }

    newBoardClickHandler(){
        this.showModalPopup=true;
    }

    noOfSectionChangeHandler(event){
        let noOfSections=event.target.value;
        this.sections=[];
        for(let i=0;i<noOfSections;i++){
            this.sections.push({ id : i, sectionLable : `Section ${i+1} Title`});
        }
    }

    async handleSubmit(event){
       event.preventDefault();
       const fields = { ...event.detail.fields};
       let sectionControls = this.template.querySelectorAll('[data-section-control]');
       let sectionList = [];
       for(let control of sectionControls){
        sectionList.push({ Name : control.value});

       } 
       if(!this.validateData(fields, sectionList)){
        return;
       }

       let result = await saveBoard({'board': fields, 'sections': sectionList});
       this.popupCloseHandler();
       this.showToast('Data saved');

    }

    validateData(fields,sectionList){
        let sectionCount = parseInt(fields.NoOfSections__c);
       
        if(!sectionCount || sectionCount < 1 || sectionCount > 10){
            this.showToast('Please enter value between 1 and 10', 'Error', 'error');
            return false;
        }
        if(sectionList.filter(a => a.Name == '').length > 0){
            this.showToast('Please enter title for every event', 'Error', 'error');
            return false;
        }
        return true;
    }

    showToast(message, title='Success', variant='success'){
        const event = new ShowToastEVent({
            title,
            message,
            variant
        });
        this.dispatchEvent(event);
    }
}