import { LightningElement, wire,api } from 'lwc';
import filterAccount from '@salesforce/apex/accountFilterController.filterAccount';

const columns = [   
{ label: 'Name', fieldName: 'Name' },
{ label: 'Account Site', fieldName: 'Website' },
{ label: 'Account Owner', fieldName: 'OwnerId'},
{ label: 'AnnualRevenue', fieldName: 'AnnualRevenue'},
{ label: 'NumberOfEmployees', fieldName: 'NumberOfEmployees'},
];

export default class listViewSectionCmp extends LightningElement {

availableAccounts;
error;
columns = columns;
initialRecords;
searchKey ='';
@api selectedControllingValue='';
@api selectedDependentValue='';
isPicklistValueChanged = false;

@wire(filterAccount, { keySearch: '$searchKey',
countryCode: '$selectedControllingValue',
stateCode: '$selectedDependentValue'
})
wiredAccount({error, data}){
if (data) {
    console.log('searchKey-------------->',this.searchKey);
    console.log('dataAccount-------------->',data);
    console.log('selectedControllingValue-------------->',this.selectedControllingValue);
    console.log('selectedDependentValue-------------->',this.selectedDependentValue);
    this.availableAccounts = data;
    this.initialRecords = data;
    this.error = undefined;
    
    } else if (error) {
    
    this.error = error;
    this.availableAccounts = undefined;
    
    }
}

connectedCallback(){
    this.handleFilter();
}

handleSearch( event ) {
    this.searchKey = event.target.value.toLowerCase();
    console.log('this.searchKey in handleSearch---->',this.searchKey);
    this.selectedControllingValue = '';
    this.selectedDependentValue = '';
    this.handleFilter();

    
}


@api handleFilter(){
    filterAccount({ keySearch: this.searchKey,
        countryCode: this.selectedControllingValue,
        stateCode: this.selectedDependentValue,
        }).then(result=>{
            console.log('searchKey-------------->',this.searchKey);
            console.log('dataAccount-------------->',result);
            console.log('selectedControllingValue-------------->',this.selectedControllingValue);
            console.log('selectedDependentValue-------------->',this.selectedDependentValue);
            this.availableAccounts = result;
            this.initialRecords = result;
            this.error = undefined;
        }).catch(error=>{
    
            this.error = error;
            this.availableAccounts = undefined;
        });
}

}