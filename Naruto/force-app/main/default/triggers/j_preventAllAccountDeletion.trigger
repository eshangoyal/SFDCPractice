//prevent the users from deleting the Accounts. This is because System Administrator has all the permissions, we cannot change the permissions.
trigger j_preventAllAccountDeletion on Account (before insert) {
    for(Account a:Trigger.old){
        a.adderror('cannot delete, admin rights needed');
    }
}