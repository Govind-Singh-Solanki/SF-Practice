trigger ContactTrigger on Contact (after update, after delete, before insert, before update) {

    if(Trigger.isAfter) {
        if(Trigger.isDelete) {
            ContactTriggerHandler.handleAccountContactCount(Trigger.old);
        }
        if(Trigger.isUpdate) {
            ContactTriggerHandler.accountUpdateOnContactUpdate(Trigger.New);
        }
    }

    if(Trigger.isBefore) {
        if(Trigger.isInsert || Trigger.isUpdate) {
            ContactTriggerHandler.handleContactEmailValidation(Trigger.New);
        }
    }

}