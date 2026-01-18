trigger ContactTrigger on Contact (after update, after delete) {

    if(Trigger.isAfter) {
        if(Trigger.isDelete) {
            ContactTriggerHandler.handleAccountContactCount(Trigger.old);
        }
        if(Trigger.isUpdate) {
            ContactTriggerHandler.accountUpdateOnContactUpdate(Trigger.New);
        }
    }

}