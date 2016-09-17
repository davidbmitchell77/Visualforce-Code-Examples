public with sharing class MyController {

    public Lead lead {get;set;}
    public List<Lead> leads {get;set;}
    private List<String> conditions = new List<String>();
    
    public MyController() {
        lead = new Lead();
        leads = new List<Lead>();
    }
    
    public void search() {
        String qrySelect = 'SELECT Name,' +
                                  'Company,' +
                                  'NumberOfEmployees,' +
                                  'Rating__c,' +
                                  'Star_Rating__c ' +
                             'FROM Lead ';
                             
        String qryWhere =  ' ';
        conditions.clear();
        if (lead.Name != null && lead.Name > '') {
          conditions.add('Name LIKE \'' + lead.Name + '%\'');
        }
        
        if (lead.Company != null && lead.Company > '') {
          conditions.add('Company LIKE \'' + lead.Company+ '%\'');
        }
        
        if (lead.NumberOfEmployees != null && lead.NumberOfEmployees > 0) {
          conditions.add('NumberOfEmployees >= ' + lead.NumberOfEmployees);
        }
        
        if (lead.Rating__c != null && lead.Rating__c > '') {
          conditions.add('Rating__c = \'' + lead.Rating__c + '\'');
        }
        
        for (Integer i=0; i<conditions.size(); i++) {
          qryWhere += ((i==0) ? ' WHERE ': ' AND ') + conditions[i];
        }
        
        String qryOrder =  ' ORDER BY Rating__c DESC';
        String qryLimit = ' LIMIT 100';
        leads = Database.query(qrySelect + qryWhere + qryOrder + qryLimit);
    }
    
    public void clear() {
        lead.clear();
        leads.clear();
    }
    
    public List<SelectOption> getOptions() {
        List<SelectOption> options = new List<SelectOption>();   
        Schema.Describefieldresult fieldResult = Schema.Lead.Rating.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();

        options.add(new SelectOption('', ''));
        for(Schema.PicklistEntry f : ple) {
            options.add(new SelectOption(f.getLabel(), f.getValue()));
        }

        return options;
    }
}