import { LightningElement,track,wire } from 'lwc';
import { getPicklistValuesByRecordType, getObjectInfo } from 'lightning/uiObjectInfoApi';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';

export default class FilterSectionCmp extends LightningElement {


@track
optionValues = {controlling:[], dependent:[]};

//To fill all controlling value and its related valid values
allDependentOptions={};

//To hold what value, the user selected.
@track
selectedValues = {controlling:undefined, dependent:undefined};

//Invoke in case of error.
isError = false;
errorMessage;

//To Disable Dependent PickList until the user won't select any parent picklist.
isDisabled = true;

@wire(getObjectInfo, {objectApiName : ACCOUNT_OBJECT})
objectInfo;
@wire(getPicklistValuesByRecordType, { objectApiName: ACCOUNT_OBJECT, recordTypeId: '$objectInfo.data.defaultRecordTypeId'})
fetchValues({error, data}){
    console.log('data--->',data);
    if(!this.objectInfo){
        this.isError = true;
        this.errorMessage = 'Wrong Object Settings';
        return;
    }
    if(data && data.picklistFieldValues){
        try{
            this.setUpControllingPicklist(data);
            this.setUpDependentPickList(data);
        }catch(err){
            this.isError = true;
            this.errorMessage = err.message;
        }
    }else if(error){
        this.isError = true;
        this.errorMessage = 'Wrong Object Settings';
    }
}
//Method to set Up Controlling Picklist
setUpControllingPicklist(data){
    this.optionValues.controlling = [{ label:'None', value:'' }];
    if(data.picklistFieldValues['BillingCountryCode']){
        data.picklistFieldValues['BillingCountryCode'].values.forEach(option => {
            this.optionValues.controlling.push({label : option.label, value : option.value});
        });
        if(this.optionValues.controlling.length == 1)
            throw new Error('No Values Available for Controlling PickList');
    }else
        throw new Error('Controlling Picklist doesn\'t seems right');
}
//Method to set up dependent picklist
setUpDependentPickList(data){
    if(data.picklistFieldValues['BillingStateCode']){
        if(!data.picklistFieldValues['BillingStateCode'].controllerValues){
            throw new Error('Dependent PickList does not have any controlling values');
        }
        if(!data.picklistFieldValues['BillingStateCode'].values){
            throw new Error('Dependent PickList does not have any values');
        }
        this.allDependentOptions = data.picklistFieldValues['BillingStateCode'];
    }else{
        throw new Error('Dependent Picklist Doesn not seems right');
    }
}
handleControllingChange(event){
    const selected = event.target.value;
    if(selected && selected != 'None'){
        this.selectedValues.controlling = selected;
        this.selectedValues.dependent = '';
        this.optionValues.dependent = [{ label:'None', value:'' }];
        let controllerValues = this.allDependentOptions.controllerValues;
        this.allDependentOptions.values.forEach( val =>{
            val.validFor.forEach(key =>{
                if(key === controllerValues[selected]){
                    this.isDisabled = false;
                    this.optionValues.dependent.push({label : val.label, value : val.value});
                }
            });
        });

        const selectedrecordevent = new CustomEvent(
                "selectedpicklists", {
                    detail : { pickListValue : this.selectedValues}
                }
            );
            this.dispatchEvent(selectedrecordevent);

        if(this.optionValues.dependent && this.optionValues.dependent.length > 1){

        }
        else{
            this.optionValues.dependent = [];
            this.isDisabled = true;
        }
    }else{
        this.isDisabled = true;
        this.selectedValues.dependent = [];
        this.selectedValues.controlling = [];
    }
}

handleDependentChange(event){
    this.selectedValues.dependent = event.target.value;
    const selectedrecordevent = new CustomEvent(
        "selectedpicklists",
        {
            detail : { pickListValue : this.selectedValues}
        }
    );
    this.dispatchEvent(selectedrecordevent);

    }
}