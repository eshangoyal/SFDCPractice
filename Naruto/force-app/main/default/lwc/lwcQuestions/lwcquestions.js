// myComponent.js
import { LightningElement, wire } from 'lwc';
import {getRecord, getFieldValue} from 'lightning/uiRecordApi';

// Import the fields you need from the object's schema
import NAME_FIELD from '@salesforce/schema/Account.Name';
import PHONE_FIELD from '@salesforce/schema/Account.Phone';
import INDUSTRY_FIELD from '@salesforce/schema/Account.Industry';

export default class MyComponent extends LightningElement {
    @api recordId;
    industry;
    phone;
    accountName;

    getFieldName(){
        if()
    }
    @wire(getRecord,{recordId: '$recordId', fields:[NAME_FIELD,PHONE_FIELD,INDUSTRY_FIELD]})
    wiredAccount({errord,data}){
        if(data){
            this.industry = getFieldValue(data,INDUSTRY_FIELD);
            this.phone = getFieldValue(data,PHONE_FIELD);
            this.accountName = getFieldValue(data,NAME_FIELD);
        }
        else if (error){
            console.log(error);
        }
    }


@wire(getRecord, {recordId:'$recordId', fields:[NAME_FIELD,PHONE_FIELD,INDUSTRY_FIELD]})
wiredAccount({data,error}){
    if(data){
        
        this.industry = getFieldValue(data,INDUSTRY_FIELD);
        this.phone = getFieldValue(data,PHONE_FIELD);
        this.accountName = getFieldValue(data,NAME_FIELD);
    }
    else 
}

    this.dispatchEvent(new customEvent('clickEvent'))
}


    <lightning-input-field field-name ="Name"></lightning-input-field>
    handleFormSubmit(event) {
        event.preventDefault();

        this.template.querySelector('lightning-record-edit-form').submit();
    }

    handleForm(event){
        event.preventDefault();
        this.template.querySelector('lightning-record-edit-form'.submit())
    }


    // dataTableExample.js
import { LightningElement, wire } from 'lwc';
import { getObjectInfo, getPicklistValues } from 'lightning/uiObjectInfoApi';
import { getRecord, updateRecord } from 'lightning/uiRecordApi';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import NAME_FIELD from '@salesforce/schema/Account.Name';
import INDUSTRY_FIELD from '@salesforce/schema/Account.Industry';
import PHONE_FIELD from '@salesforce/schema/Account.Phone';
import ACTIVE_FIELD from '@salesforce/schema/Account.IsActive__c';

export default class DataTableExample extends LightningElement {
    accounts = [];
    columns = [
        { label: 'Name', fieldName: 'Name', type: 'text' },
        { label: 'Industry', fieldName: 'Industry', type: 'text' },
        { label: 'Phone', fieldName: 'Phone', type: 'phone' },
        { label: 'Active', type: 'component', fieldName: 'IsActive__c', typeAttributes: { template: 'checkbox' } }
    ];

    @wire(getObjectInfo, { objectApiName: ACCOUNT_OBJECT })
    accountObjectInfo;

    @wire(getRecord, { recordId: '$recordId', fields: [NAME_FIELD, INDUSTRY_FIELD, PHONE_FIELD, ACTIVE_FIELD] })
    accountRecord;

    get recordId() {
        return this.accounts.length > 0 ? this.accounts[0].Id : undefined;
    }

    connectedCallback() {
        // Fetch the account records
        // ... add your logic here to fetch account data
    }

    handleRowAction(event) {
        // Handle row actions
        // ... add your logic here to handle row actions
    }
}
