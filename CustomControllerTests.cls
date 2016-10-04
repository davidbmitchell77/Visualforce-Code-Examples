@isTest(SeeAllData=true)
private class CustomControllerTests {
    static TestMethod void AlienMindController() {
        /* ------------------------------------------------ */
        /* Get reference to VF page; set current page and   */
        /* instantiate the custom controller                */
        /* ------------------------------------------------ */
        ApexPages.PageReference myPageRef = Page.AlienMindControl;
        Test.SetCurrentPage(myPageRef);
        AlienMindController amc = new AlienMindController();
        
        /* ------------------------------------------------ */
        /* Get the country and state dropdown lists         */
        /* ------------------------------------------------ */
        List<SelectOption> countries = amc.getCountries();
        List<SelectOption> states = amc.getStates();
        
        /* ------------------------------------------------ */
        /* Init search fields, run search, sort records,    */
        /* (call all sort methods twice for ascending /     */
        /* descending order), confirm record count > 0      */
        /* ------------------------------------------------ */
        amc.searchName = '';
        amc.searchAccount = '';
        amc.searchCity = '';
        amc.searchState = '';
        amc.selectedCountry1 = '';
        amc.search();
        amc.sortByAccount();
        amc.sortByAccount();
        amc.sortByName();
        amc.sortByName();
        amc.sortByIsExecutive();
        amc.sortByIsExecutive();
        amc.sortByCity();
        amc.sortByCity();
        amc.sortByState();
        amc.sortByState();
        amc.sortByCountry();
        amc.sortByCountry();
        amc.sortById();
        amc.sortById();
        List<Contact> searchResults = amc.getAliens();
        System.assertEquals(searchResults.size() > 0, true);
        
        /* ------------------------------------------------ */
        /* Clear the results, confirm record count is 0     */
        /* ------------------------------------------------ */
        amc.clear();
        searchResults = amc.getAliens();
        System.assertEquals(searchResults.size() == 0, true);
        
        /* ------------------------------------------------ */
        /* Run bogus search, confirm record count is 0      */
        /* ------------------------------------------------ */
        amc.searchName = 'No Name';
        amc.searchAccount = 'No Account';
        amc.searchCity = 'No City';
        amc.searchState = 'No State';
        amc.selectedCountry1 = 'No Country';
        amc.search();
        searchResults = amc.getAliens();
        System.assertEquals(searchResults.size() == 0, true);
    }
    
    static TestMethod void MyCustomSetController() {
    	
    	// Get a reference to the VF page, set as current page
        PageReference pageRef = Page.MyCustomSetController;
        Test.setCurrentPage(pageRef);
        
        // Instantiate the custom controller
        MyCustomSetController myCSC = new MyCustomSetController();
        
        // Populate the States picklist
        List<SelectOption> states = new List<SelectOption>();
        states = myCSC.getStates();
        
        // Search for City = "Chicago"
        myCSC.sCity = 'Chicago';
        myCSC.search();
        
        // Sort the results
        myCSC.sortByName();  // sort ascending
        myCSC.sortByName();  // sort descending
        
        // Confirm records were found
        List<Account> searchResults = new List<Account>();
        searchResults = myCSC.getAccounts();
        System.assertEquals(searchResults.Size() > 0, true);
        
        // Clear the VF page, confirm no records in list
        myCSC.clear();
        searchResults = myCSC.getAccounts();
        System.assertEquals(searchResults, null);
        
        // Search for bogus State = "NF" and confirm no recs found
        myCSC = new MyCustomSetController();
        myCSC.sState = 'NF';
        myCSC.search();
        searchResults = myCSC.getAccounts();
        System.assertEquals(searchResults.Size(), 0);
    }
}