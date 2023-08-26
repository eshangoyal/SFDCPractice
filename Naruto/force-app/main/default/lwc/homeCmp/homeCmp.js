import { LightningElement } from 'lwc';

export default class HomeCmp extends LightningElement {
    
    selectedvalues;
    selectedControllingValue='';
    selectedDependentValue='';
    
    
    handlePicklist(event) {
        let selectedValues = event.detail.pickListValue;
        console.log('selectedValues------------>', selectedValues);
        this.selectedvalues = JSON.parse(JSON.stringify(selectedValues));
        this.selectedControllingValue = this.selectedvalues.controlling;
        this.selectedDependentValue = this.selectedvalues.dependent;
        this.template.querySelector('c-list-view-section-cmp').handleFilter();
         console.log('checking handle Picklist');
    }
}