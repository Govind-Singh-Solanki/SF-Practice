public with sharing class OpportunityTriggerHandler {
    public static void handleAccountMaxOpp(List<Opportunity> oppList, Map<Id, Opportunity> oppMap) {
        Set<Id> accIds = new Set<Id>();
        if(!oppList.isEmpty()) {
            for(Opportunity opp : oppList) {
                if(oppMap != null) {
                    Opportunity oldOpp = oppMap.get(opp.Id);
                    if(oldOpp.AccountId != opp.AccountId) {
                        accIds.add(oldOpp.AccountId);
                        accIds.add(opp.AccountId);
                    } else { accIds.add(opp.AccountId); }
                } else { accIds.add(opp.AccountId); }
            }
        }

        List<Account> accListToUpdate = new List<Account>();
        List<Account> queriedAccountList = [SELECT Id, Max_Opp__c, (SELECT Id, Name, Amount FROM Opportunities WHERE Amount != null Order By Amount DESC LIMIT 1) FROM Account WHERE Id IN :accIds];


        if(!queriedAccountList.isEmpty()) {
            for(Account acc : queriedAccountList) {
                acc.Max_Opp__c = acc.Opportunities[0].Name;
                accListToUpdate.add(acc);
            }
        }

        if(!accListToUpdate.isEmpty()){
            update accListToUpdate;
        }
    }

    public static void handleTaskCreaation(List<Opportunity> newOppList, Map<Id, Opportunity> oldOppMap) {
        List<Task> newTaskList = new List<Task>();
        for(Opportunity opp : newOppList) {
            if(opp.StageName == 'Closed Won' && oldOppMap.get(opp.Id).StageName != 'Closed Won') {
                Task t = new Task();
                t.Subject = 'Follow up on Closed Won Opportunity -- ' + opp.Name;
                t.Priority = 'Normal';
                t.Status = 'Not Started';
                t.WhatId = opp.Id;
                newTaskList.add(t);
            }
        }

        Database.insert(newTaskList, false);
    }

}