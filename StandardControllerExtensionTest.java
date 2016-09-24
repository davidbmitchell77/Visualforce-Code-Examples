@isTest
private class StandardControllerExtensionTest {
    Public static testMethod void testRatingChangeSave() {
        Account acct = new Account(name='Test');
        insert acct;
        List<Opportunity> childOpps = new List<Opportunity>();
        for (Integer i=0; i<4; i++) {
            childOpps.add(
                new Opportunity(
                    AccountId = acct.Id,
                    Name = 'Test Opportunity ' + i,
                    StageName = 'Prospecting',
                    CloseDate = Date.Today() + 3
                )
            );
        }
        childOpps[0].StageName = 'Closed Won';
        childOpps[1].StageName = 'Closed Lost';
        insert childOpps;
        
        Test.startTest();
        //Get a reference to the standard controller:
        ApexPages.StandardController sc = new ApexPages.StandardController(acct);
        //Now get  a reference to your controller extension:
        StandardControllerExtension sce = new StandardControllerExtension(sc);
        //Change rating, then mimic clicking the save button...
        sce.acct.Rating = 'Hot';
        sce.save();
        Test.stopTest();
        
        //Assert correct no. of child oppty records inserted:
        System.assertEquals(4, sce.getOpportunities().size());
        
        //Fetch tasks that were added to open opptys:
        Set<Id> childOppsIds = new Set<Id>();
        for (Opportunity o : sce.getOpportunities()) {
            childOppsIds.add(o.Id);
        }
        
        //Assert correct no. tasks where inserted:
        List<Task> addedTasks = [SELECT Id FROM Task WHERE WhatId IN :childOppsIds];
        System.assertEquals(2, addedTasks.size());
    }
}