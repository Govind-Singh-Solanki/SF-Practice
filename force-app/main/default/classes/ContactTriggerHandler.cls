public with sharing class ContactTriggerHandler {

    private static final String EMAIL_REGEX = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,6}$';

    public static void handleContactEmailValidation(List<Contact> conList) {

        for(Contact con : conList) {
            if(con.Dummy_Email__c == null) {
                con.addError('Email cannot be empty!');
                return;
            } else {
                if(validateEmail(con.Dummy_Email__c) == false) {
                    con.addError('Invalid email format!');
                }
            }
        }

    }
    
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
    
    //Method to validate email format (regular expression)
    public static Boolean validateEmail(String email) {
        if(email == null){
            return false;
        }
        Pattern emailPattern = Pattern.compile(EMAIL_REGEX);
        Matcher emailMatcher = emailPattern.matcher(email);

        return emailMatcher.matches();
    }

}