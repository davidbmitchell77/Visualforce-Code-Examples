@isTest
private class CustomControllerTestClass {
    static testMethod void testMyPage () {}
        public Account acct = new Account(Name='Test');
        insert acct;
        List<Opportunity> childOpptys = new List<Opportunity>();
        for (Integer i=0; i<4; i++) {
            Opportunity o = new Opportunity();
            o.AccountId = acct.Id;
            o.Name = acct.Name + i;
            o.StageName = 'Prospecting;';
            o.CloseDate = Date.today() + 3;
            childOpptys.add(o);
        }
        insert childOpptys;
        
        Test.startTest();
        PageReference myPageRef = Page.MyVisualForcePage; //<-- change to: Page.{your visualforce page name}
        Test.setCurrentPageReference(myPageRef);
        myPageRef.getParameters().put('id', acct.Id);
        CustomController cc = new CustomController(); //<-- change to: new {your custom controller class name}
        cc.acct.Rating = 'Hot';
        cc.save();
        Test.stopTest();
        
        // assert number of child opportunities
        System.assertEquals(4, cc.getOpportunities.size());
        Set<Id> childOppsIds = new Set<Id>();
        for (Opportunity o : cc.getOpportunities()) {
            childOppsIds.add(o.Id);
        }
        
        // assert number of child opportunity tasks
        List<Task> addedTasks = [SELECT Id FROM Task WHERE Id IN :childOppsIds];
        System.assertEquals(2, addedTasks.size());
    }
}
