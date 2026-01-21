public with sharing class AccountTriggerHandler {
    
    public static void verifyBillingShippingAddress(List<Account> accList, Map<Id, Account> oldAccMap) {

        for(Account acc : accList){
            if(acc.Industry != null) {
                // acc.ShippingCity = acc.BillingCity;
                // acc.ShippingCountry = acc.BillingCountry;
                // acc.ShippingPostalCode = acc.BillingPostalCode;
                // acc.ShippingStreet = acc.BillingStreet;
                // acc.ShippingState = acc.BillingState;
                acc.Description = 'Industry is set to ' + acc.Industry;
            }
            if(acc.BillingCountryCode != null){
                acc.ShippingCountryCode = acc.BillingCountryCode;
            }
        }

    }

    public static void handleAccountDeletion(List<Account> accList) {

        for(Account acc : accList) {
            if(acc.Active__c == 'Yes'){
                acc.addError('Active accounts cannot be deleted.');
            }
        }

    }

    // Method for preventing acount duplication based on account name
    public static void handleAccountDuplication(List<Account> accList) {

        Set<Id> accIdSet = new Set<Id>();
        Map<Id, Account> accMap = new Map<Id, Account>();
 
        for(Account acc : accList) {
            accIdSet.add(acc.Id);
        }

        List<Account> existingAccList = [SELECT Id, Name FROM Account WHERE Id IN :accIdSet];

        for(Account existingAcc : existingAccList) {
            accMap.put(existingAcc.Id, existingAcc);
        }

        for(Account acc : accList) {
            if(acc.Name == accMap.get(acc.Id).Name) {
                acc.addError('Account with same name already exists.');
            }
        }
        
    }

}