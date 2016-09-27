@isTest
public class ProjectCreateTests
{
    @isTest
    public static void TestControllerExtension() {
        Project__c = new Project__c();
        ApexPages.StandardController sc = new ApexPages.StandardController(project);
        ProjectCreateExtension pce = new ProjectCreateExtension(Sc)
        project.Name = 'Test Project';
        project.Budget__c = 1000;
        project.Start_Date__c = System.Today();
        pce.ToPage2();
        System.Assert([SELECT Id FROM Project__c] .Size() == 1);
    }
}