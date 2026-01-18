trigger AccountTrigger on Account (before update, before delete) {

    // if(Trigger.isBefore && Trigger.isUpdate) {
    //     AccountTriggerHandler.verifyBillingShippingAddress(Trigger.new, Trigger.oldMap);
    // }

    if(Trigger.isBefore) {

        // Trigger to stop the Account deletion record with “Active” status.
        if(Trigger.isDelete) {
            AccountTriggerHandler.handleAccountDeletion(Trigger.old);
        }
        
    }

}