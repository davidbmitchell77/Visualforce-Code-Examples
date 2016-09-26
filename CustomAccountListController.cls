public class CustomAccountListController {
    
  public ApexPages.StandardSetController ssc {get; private set;}
  public List<SelectOption> sizeOptions {get; private set;}
  public String chosenSize {get; set;}
  
  public CustomAccountListController() {
    ssc = new ApexPages.StandardSetController([SELECT Id,
                                                      Name,
                                                      Rating,
                                                      BillingCity,
                                                      BillingState,
                                                      Phone,
                                                      NumberOfEmployees
                                                 FROM Account
                                             ORDER BY Name
                                                LIMIT 500]);
                                                
    sizeOptions = new List<SelectOption>();
    sizeOptions.add(new SelectOption('small', 'Small'));
    sizeOptions.add(new SelectOption('medium', 'Medium'));
    sizeOptions.add(new SelectOption('large', 'Large'));
    sizeOptions.add(new SelectOption('any', 'Any Size'));
    chosenSize = 'any';
    applyFilter();
  }
  
  public List<Account> GetAccounts() {
    return (List<Account>)ssc.GetRecords();
  }
  
  public PageReference applyFilter() {
    String query = 'Select Id, Name, Rating, BillingCity, BillingState, Phone, NumberOfEmployees from Account ';
    if (ssc.GetRecords().Size() == 0) {
      ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.Info, 'No matching accounts found.'));
    }
    
    if (chosenSize == 'small') {
      query += ' Where NumberOfEmployees <= 100 ';
    } else if (chosenSize == 'medium') {
      query += ' Where NumberOfEmployees > 100 and NumberOfEmployees <= 500 ';
    } else if (chosenSize == 'large') {
      query += ' Where NumberOfEmployees > 500 ';
    } 
    
    query += ' Order By Name ';
    query += ' Limit 500 ';
    
    ssc = new ApexPages.StandardSetController(Database.Query(query));
    
    return null;
  }

}