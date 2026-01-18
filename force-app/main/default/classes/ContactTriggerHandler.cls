public with sharing class ContactTriggerHandler {
    
    public static void handleAccountContactCount(List<Contact> conList) {

        Set<Id> accIds = new Set<Id>();
        List<Account> accList = new List<Account>();
        
        for(Contact con : conList){
            accIds.add(con.AccountId);
        }

        for(Account acc : [SELECT Id, (SELECT Id FROM Contacts) FROM Account WHERE Id IN :accIds]) {
            Account accToUpdate = new Account();
            accToUpdate.Id = acc.Id;
            accToUpdate.Contact_Count__c = acc.Contacts.size();
            accList.add(accToUpdate);
        }

        if(!accList.isEmpty()) {
            update accList;
        }

    }

    public static void accountUpdateOnContactUpdate(List<Contact> conList) {

        Set<Id> accIdSet = new Set<Id>();

        for(Contact con : conList) {
            if(con.AccountId != null) {
                accIdSet.add(con.AccountId);
            }
        }

        if(accIdSet.isEmpty()) {
            return;
        }
        
        List<Account> accList = [SELECT Id, Description FROM Account WHERE Id IN :accIdSet];

        for(Account acc : accList) {
            acc.Description = 'Related contact last updated on ' + Date.Today().format();
        }

        // Database.update(accList, false);
        update accList;

    }

}