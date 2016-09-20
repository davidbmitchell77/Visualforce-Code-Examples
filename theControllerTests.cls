@isTest
private class thecontrollerTests {

    static testMethod void testMyController() {
        PageReference pageRef = Page.success;
        Test.setCurrentPage(pageRef);
      
        thecontroller controller = new thecontroller();
        String nextPage = controller.save().getUrl();

        // Verify that page fails without parameters
        System.assertEquals('/apex/failure?error=noParam', nextPage);

        // Add parameters to page URL
        ApexPages.currentPage().getParameters().put('qp', 'yyyy');
      
        // Instantiate a new controller with all parameters in the page
        controller = new thecontroller(); 
        controller.setLastName('lastname');
        controller.setFirstName('firstname');
        controller.setCompany('acme');
        controller.setEmail('firstlast@acme.com');
        nextPage = controller.save().getUrl();

        // Verify that the success page displays
        System.assertEquals('/apex/success', nextPage);
        Lead[] leads = [select id, email from lead where Company = 'acme'];
        System.assertEquals('firstlast@acme.com', leads[0].email);
    }
}