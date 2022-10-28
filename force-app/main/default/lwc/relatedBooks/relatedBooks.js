import { LightningElement, wire, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getRelatedBooks from '@salesforce/apex/RelatedBooksLWC.getRelatedBooks';

import NAME_FIELD from '@salesforce/schema/Book__c.Name';
import AUTHOR_FIELD from '@salesforce/schema/Book__c.Author__c';

const columns = [
    { label: 'Name of the book', fieldName: NAME_FIELD.fieldApiName},
    { label: 'Author', fieldName: AUTHOR_FIELD.fieldApiName}
];

export default class RelatedBooks extends LightningElement {
    columns = columns;
    @api recordId;

    @wire(getRelatedBooks, {readerId:'$recordId'})books;

    connectedCallback(){
        console.log('Id '+ this.recordId);
        console.info(JSON.stringify(getRelatedBooks(this.recordId)));
    }

    handleClick(){
        console.log(JSON.stringify(this.books.data));
        const event = new ShowToastEvent({
            title: 'Sorry',
            message: 'Refresh integration is not yet configured'
        });
        this.dispatchEvent(event);
        
    }
}