public with sharing class MyCustomSetController {

  public ApexPages.StandardSetController ssc {get; set;}
  public String sName {get; set;}
  public String sCity {get; set;}
  public String sState {get; set;}
  public Boolean recsFound {get; set;}

  private String query;
  private String sortOrder = 'Name ASC';
  private Integer qLimit = 5000;
  public MyCustomSetController() {
    ssc = new ApexPages.StandardSetController(Database.getQueryLocator(queryStatement(sortOrder, qLimit)));
    recsFound = (ssc.getResultSize() > 0);
  }

  public String queryStatement(String sortOrder, Integer maxRecs) {
    query = 'SELECT Id,' +
                   'Name,' +
                   'Type,' +
                   'Description,' +
                   'BillingCity,' +
                   'BillingState,' +
                   'Phone' +
             ' FROM Account ';
    query += whereClause();
    query += orderBy(sortOrder);
    query += queryLimit(maxRecs);

    return query;
  }
  
  public List<Account> getAccounts() {
    if (ssc != null) {
      return (List<Account>)ssc.GetRecords();
    } else {
      return null;
    }
  }

  public List<SelectOption> getStates() {

    // Load all state records from the custom setting
    Map<String, USStatePostalCodes__c> states = USStatePostalCodes__c.getAll();

    // Sort them by name
    List<String> stateNamesList = new List<String>();
    stateNamesList.addAll(states.keySet());
    stateNamesList.sort();

    // Create the Select Options.
    List<SelectOption> options = new List<SelectOption>();
    options.add(new SelectOption('', ''));
    for (String stateName : stateNamesList) {
        USStatePostalCodes__c state = states.get(stateName);
        options.add(new SelectOption(state.StateCode__c, state.Name + ' (' + state.StateCode__c + ')'));
    }

    return options;
  }

  private String whereClause() {
    String result = '';

    List<String> conditions = new List<String>();
    if (sName > '') {conditions.add('Name LIKE \'' + sName + '%\'');}
    if (sCity > '') {conditions.add('BillingCity LIKE \'' + sCity + '%\'');}
    if (sState > '') {conditions.add('BillingState = \'' + sState + '\'');}

    for (Integer i=0; i<conditions.Size(); i++) {
      result += ((i==0) ? ' WHERE ' : ' AND ') + conditions[i];
    }
    
    return result;
  }
  
  private String orderBy(String orderClause) {
    String result = '';
    result += ' ORDER BY ';
    result += orderClause + ' ';
    return result;
  }

  private String queryLimit(Integer reclimit) {
    String result = '';
    result = ' LIMIT ' + reclimit;
    return result;
  }
  
  public void sortByName() {
    sortOrder = 'Name ASC';
    if (query.Contains(' Name ASC ')) {
      sortOrder = 'Name DESC';
    }
    ssc = new ApexPages.StandardSetController(Database.getQueryLocator(queryStatement(sortOrder, qLimit)));
    recsFound = (ssc.getResultSize() > 0);
  }
  
  public PageReference search() {
    ssc = new ApexPages.StandardSetController(Database.getQueryLocator(queryStatement(sortOrder, qLimit)));
    recsFound = (ssc.getResultSize() > 0);
    if (!recsFound) {
      ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Info, 'No matching customer account records found.'));
      ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Info, 'Please adjust your search criteria and try again.'));
    } else {
      ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm, ssc.getResultSize() + ' record(s) found.'));
    }
    return null;
  }
  
  public PageReference clear() {
    sName = '';
    sCity = '';
    sState = '';
    ssc = null;
    recsFound = false;
    return null;
  }
}