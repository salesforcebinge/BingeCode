public inherited sharing class SearchAccountsLWCController {
    
    @AuraEnabled (Cacheable = true)
    public static List<Account> getAccountsByZipCode(String zipCode, Integer soqlLimit){
        try {
            zipCode = '%' + zipCode + '%';
            List<Account> accountList = [SELECT Id, Name, Phone, Industry, BillingPostalCode, BillingCity, BillingState, BillingStreet, BillingCountry FROM Account WHERE BillingPostalCode LIKE :zipCode LIMIT :soqlLimit];

            if (accountList.isEmpty()) {
                throw new AuraHandledException('No Accounts in this area : '+zipCode);
            }

            return accountList;
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}