import { LightningElement, wire } from 'lwc';
import getContacts from '@salesforce/apex/basicLWCController.getContacts';
import getAccounts from '@salesforce/apex/basicLWCController.getAccounts';
import deleteAccount from '@salesforce/apex/basicLWCController.deleteAccountById'

export default class BasicLWC extends LightningElement {

name="hello";
contactId='0035j00000rO6G8';
accountIdToBeDeleted='';
accountArray=[];
error ='';

const x = [];

updateName(event){
   console.log(event.target.value);
   this.name=event.target.value;
   console.log('contactData',JSON.stringify(this.contactData));
   
}

//Simple wire method with a direct property assignment with a parameter
@wire(getContacts,{recordId:'$contactId'})
contactData;

//Wire method with a method property
@wire(getAccounts)
fetchAccountData(response){
let data = response.data;
let error = response.error;

let testCommit;
if(data){
   data.forEach(a=>{
      this.accountArray.push({
         recordId: a.Id,
         accontName: a.Name,
         Phone: a.Phone
      })
   });
   console.log('data',data);
   console.log('this.accountArray',this.accountArray);
   
}
else if(error){
   console.log('error',error)
}
}

//Imperative Call To Fetch Account Details
//getAccounts({id: this.id}).then().catch();
handleFetchAccountButton(){
   getAccounts().then(result=>{
      this.accountArray = result;
   }).catch(error =>{
      this.error = error;
   });
}

//OnChange Method to get the id of account
updateAccountIdToBeDeleted(event){
this.accountIdToBeDeleted = event.target.value;
console.log('this.accountIdToBeDeleted --->',this.accountIdToBeDeleted);
}

//On click of the delete button
handleDeleteAccount(response){
   deleteAccount({accountId: this.accountIdToBeDeleted})
   console.log(response.error);
};

}