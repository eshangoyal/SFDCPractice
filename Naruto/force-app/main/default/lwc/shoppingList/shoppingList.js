import { LightningElement, track, wire } from 'lwc';
import fetchShoppingRecords from '@salesforce/apex/shoppingListController.fetchShoppingRecords';
export default class ShoppingList extends LightningElement {
@track
shoppingList=[];


newItem = '';

//will update newItem value on change
updateNewItem(event){
    this.newItem = event.target.value;
}

handleAdd(){

    //if we want to add new item to the last
    this.shoppingList.push({
        id:this.shoppingList.length+1,
        name:this.newItem
    });

     //if we want to add new item to the first  
    /*
    this.shoppingList.unshift({
        id:this.shoppingList.length+1,
        name:this.newItem
    });
    */
    this.newItem='';
    console.log(this.shoppingList);
}

handleDelete(event){
    console.log('id to be deleted---',event.target.name)

    let shoppingList = this.shoppingList;
    let idToBeDeleted = event.target.name;
    let indexToBeDeleted;

   /* for(let i=0;i<shoppingList.length;i++){
        if(idToBeDeleted === shoppingList[i].id){
            indexToBeDeleted = i;
        }
    }
    shoppingList.splice(indexToBeDeleted,1);
    */
   
    /*
    shoppingList.splice(shoppingList.findIndex(function(newItem){
        return newItem.id === idToBeDeleted;
    }),1);
    */

    shoppingList.splice(shoppingList.findIndex(sList=>sList.id === idToBeDeleted),1);

    console.log('indexToBeDeleted',indexToBeDeleted);
}

//HOW TO CALL WIRE METHOD FROM LWC
//@wire(methodName) ProperNameToBeAssigned/methodName;
//@wire(methodName,{parameter: '$localvariable'}) ProperNameToBeAssigned/methodName;

    @wire(fetchShoppingRecords)
    getshoppingList(response){
        let data = response.data;
        let error = response.error;

        if(data){
           console.log('data',data);

        data.forEach(tempItem=>{
            this.shoppingList.push({
                id:this.shoppingList.length +1,
                item:tempItem.Item__c,
                recordId: tempItem.Id

            })
        });
        }
        else if (error){
            console.log('error',error);
        }
    };

}