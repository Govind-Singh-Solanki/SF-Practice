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

}