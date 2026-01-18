trigger AccountTrigger on Account (before update, before delete) {

    // if(Trigger.isBefore && Trigger.isUpdate) {
    //     AccountTriggerHandler.verifyBillingShippingAddress(Trigger.new, Trigger.oldMap);
    // }

    if(Trigger.isBefore) {

        if(Trigger.isDelete) {
            AccountTriggerHandler.handleAccountDeletion(Trigger.old);
        }
        
    }

}