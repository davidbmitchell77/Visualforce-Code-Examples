public class StandardControllerExtension {
    Public Account acct;
    Public List<Opportunity> Opportunities = new List<Opportunity>();
    
    public StandardControllerExtension(ApexPages.standardController std) {
        acct = (Account)std.getRecord();
    }
    
    public List<Opportunity> getOpportunities() {
        Opportunities = [SELECT Id,
                         Name,
                         Amount,
                         StageName,
                         CloseDate,
                         IsClosed,
                         OwnerId
                    FROM Opportunity
                   WHERE AccountId = :acct.Id
                   LIMIT 100];
         return Opportunities;
    }
    
    private void createTaskOnChildOppty() {
        List<Task> tasksToInsert = new List<Task>();
        for (Opportunity o : getOpportunities()) {
            if (!o.IsClosed) {
                tasksToInsert.add(
                    new Task(
                        WhatId = o.Id,
                        OwnerId = o.OwnerId,
                        ActivityDate = Date.today() + 3,
                        Status = 'Not Started',
                        Priority = 'Normal',
                        Subject = 'Send follow-up email to primary contact'
                    )
                );
            }
        }
        if (taskstoInsert.size() > 0) {
            insert tasksToInsert;
        }
    }
    
    public PageReference save() {
        if (acct.Rating == 'Hot') {
            createTaskOnChildOppty();
        }
        update acct;
        return new PageReference('/' + acct.Id);
    }
}