trigger OpportunityTrigger on Opportunity (after insert, after update, after delete, after undelete) {
    
    // if(Trigger.isAfter && Trigger.isUpdate) {
    //     OpportunityTriggerHandler.handleAccountMaxOpp(Trigger.new, Trigger.oldMap);
    // } else if(Trigger.isAfter && Trigger.isDelete) {
    //     OpportunityTriggerHandler.handleAccountMaxOpp(Trigger.old, null);
    // } else { 
    //     OpportunityTriggerHandler.handleAccountMaxOpp(Trigger.new, null); 
    // }

    // Trigger that creates a follow-up task automatically when an Opportunity is marked as “Closed Won.”
    if(Trigger.isAfter) {
        if(Trigger.isUpdate) {
            OpportunityTriggerHandler.handleTaskCreaation(Trigger.New, Trigger.OldMap);
        }
    }

}