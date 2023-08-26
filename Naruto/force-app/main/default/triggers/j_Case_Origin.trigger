//When ever a case is created with origin as email then set status as new and Priority as Medium.


trigger j_Case_Origin on Case (before insert) {
    if(Trigger.isBefore){
        if(Trigger.isInsert){
            for(Case c:Trigger.new){
                if(c.origin == 'Email'){
                    c.status = 'New';
                    c.Priority = 'Medium';                }
            }
        }
    }
}