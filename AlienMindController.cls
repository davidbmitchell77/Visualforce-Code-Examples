public with sharing class AlienMindController {
    public String searchName {get; set;}
    public String searchAccount {get; set;}
    public String searchCity {get; set;}
    public String searchState {get; set;}
    public String selectedCountry1 {get; set;}
        
    private String searchQuery = 'SELECT Id,' +
                                        'Name,' +
                                        'Account.Name,' +
                                        'is_Executive__c,' +
                                        'Phone,' +
                                        'MobilePhone,' +
                                        'MailingCity,' +
                                        'MailingState,' +
                                        'MailingCountry ' +
                                   'FROM Contact ';
                                
    private String searchQueryWhereClause = '';
    public String sortOrder = '';
    private String searchQueryLimit = ' LIMIT 100';
    private List<Contact> contacts = new List<Contact>();
    
    public AlienMindController () {
        contacts = Database.query(searchQuery + SearchQueryLimit);
    }
    
    public List<Contact> getAliens() {
        return contacts;
    }
    
    public List<SelectOption> getCountries() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('',''));
        options.add(new SelectOption('US','United States'));
        options.add(new SelectOption('CANADA','Canada'));
        options.add(new SelectOption('MEXICO','Mexico'));
        options.add(new SelectOption('UK','United Kingdom'));
        options.add(new SelectOption('FRANCE','France'));
        return options;
    }
    
    public List<selectOption> getStates() {
        List<SelectOption> options = new List<SelectOption>();
            options.add(new SelectOption('', ''));
            options.add(new SelectOption('AL', 'Alabama'));
            options.add(new SelectOption('AK', 'Alaska'));
            options.add(new SelectOption('AZ', 'Arizona'));
            options.add(new SelectOption('AR', 'Arkansas'));
            options.add(new SelectOption('CA', 'California'));
            options.add(new SelectOption('CO', 'Colorado'));
            options.add(new SelectOption('CT', 'Connecticut'));
            options.add(new SelectOption('DC', 'District of Columbia'));
            options.add(new SelectOption('DE', 'Delaware'));
            options.add(new SelectOption('FL', 'Florida'));
            options.add(new SelectOption('GA', 'Georgia'));
            options.add(new SelectOption('HI', 'Hawaii'));
            options.add(new SelectOption('ID', 'Idaho'));
            options.add(new SelectOption('IL', 'Illinois'));
            options.add(new SelectOption('IN', 'Indiana'));
            options.add(new SelectOption('IA', 'Iowa'));
            options.add(new SelectOption('KS', 'Kansas'));
            options.add(new SelectOption('KY', 'Kentucky'));
            options.add(new SelectOption('LA', 'Louisiana'));
            options.add(new SelectOption('ME', 'Maine'));
            options.add(new SelectOption('MD', 'Maryland'));
            options.add(new SelectOption('MA', 'Massachusetts'));
            options.add(new SelectOption('MI', 'Michigan'));
            options.add(new SelectOption('MN', 'Minnesota'));
            options.add(new SelectOption('MS', 'Mississippi'));
            options.add(new SelectOption('MO', 'Missouri'));
            options.add(new SelectOption('MT', 'Montana'));
            options.add(new SelectOption('NE', 'Nebraska'));
            options.add(new SelectOption('NV', 'Nevada'));
            options.add(new SelectOption('NH', 'New Hampshire'));
            options.add(new SelectOption('NJ', 'New Jersey'));
            options.add(new SelectOption('NM', 'New Mexico'));
            options.add(new SelectOption('NY', 'New York'));
            options.add(new SelectOption('NC', 'North Carolina'));
            options.add(new SelectOption('ND', 'North Dakota'));
            options.add(new SelectOption('OH', 'Ohio'));
            options.add(new SelectOption('OK', 'Oklahoma'));
            options.add(new SelectOption('OR', 'Oregon'));
            options.add(new SelectOption('PA', 'Pennsylvania'));
            options.add(new SelectOption('PR', 'Puerto Rico'));
            options.add(new SelectOption('RI', 'Rhode Island'));
            options.add(new SelectOption('SC', 'South Carolina'));
            options.add(new SelectOption('SD', 'South Dakota'));
            options.add(new SelectOption('TN', 'Tennessee'));
            options.add(new SelectOption('TX', 'Texas'));
            options.add(new SelectOption('UT', 'Utah'));
            options.add(new SelectOption('VT', 'Vermont'));
            options.add(new SelectOption('VA', 'Virginia'));
            options.add(new SelectOption('WA', 'Washington'));
            options.add(new SelectOption('WV', 'West Virginia'));
            options.add(new SelectOption('WI', 'Wisconsin'));
            options.add(new SelectOption('WY', 'Wyoming'));
            options.add(new SelectOption('VI', 'U.S. Virgin Islands'));
            options.add(new SelectOption('GU', 'Guam'));
            return options;
    }
    
    public void search() {
        searchQueryWhereClause = '';
        string sWhere = '';
        if (searchName > '') {
                sWhere = ((sWhere == '') ? ' WHERE ' : ' AND ');
                searchQueryWhereClause += sWhere + ' Name LIKE \'' + searchName + '%\'';
        }
        if (searchAccount > '') {
                sWhere = ((sWhere == '') ? ' WHERE ' : ' AND ');
                searchQueryWhereClause += sWhere + ' Account.Name LIKE \'' + searchAccount + '%\'';
        }
        if (searchCity > '') {
                sWhere = ((sWhere == '') ? ' WHERE ' : ' AND ');
                searchQueryWhereClause += sWhere + ' MailingCity LIKE \'' + searchCity + '%\'';
        }
        if (searchState > '') {
                sWhere = ((sWhere == '') ? ' WHERE ' : ' AND ');
                searchQueryWhereClause += sWhere + ' MailingState = \'' + searchState + '\'';
        }
        if (selectedCountry1 > '') {
                sWhere = ((sWhere == '') ? ' WHERE ' : ' AND ');
                searchQueryWhereClause += sWhere + ' MailingCountry LIKE \'' + selectedCountry1 + '%\'';
        }
        contacts = Database.query(searchQuery + searchQueryWhereClause + sortOrder + searchQueryLimit);
    }
    
    public void clear() {
        searchAccount = '';
        searchName = '';
        searchCity = '';
        searchState = '';
        selectedCountry1 = '';
        sortOrder = '';
        contacts.clear();
    }
    
    public void sortByAccount () {
      if (sortOrder == ' ORDER BY Account.Name ASC ') {
        sortOrder = ' ORDER BY Account.Name DESC ';
      }
      else {
        sortOrder = ' ORDER BY Account.Name ASC ';
      }
      search();
    }
    
    public void sortByName () {
      if (sortOrder == ' ORDER BY Name ASC ') {
        sortOrder = ' ORDER BY Name DESC ';
      }
      else {
        sortOrder = ' ORDER BY Name ASC ';
      }
      search();
    }
    
    public void sortByIsExecutive() {
      if (sortOrder == ' ORDER BY Is_Executive__c ASC ') {
        sortOrder = ' ORDER BY Is_Executive__c DESC ';
      }
      else {
        sortOrder = ' ORDER BY Is_Executive__c ASC ';
      }
      search();
    }
    
    public void sortByCity () {
      if (sortOrder == ' ORDER BY MailingCity ASC ') {
        sortOrder = ' ORDER BY MailingCity DESC ';
      }
      else {
        sortOrder = ' ORDER BY MailingCity ASC ';
      }
      search();
    }
    
    public void sortByState () {
      if (sortOrder == ' ORDER BY MailingState ASC ') {
        sortOrder = ' ORDER BY MailingState DESC ';
      }
      else {
        sortOrder = ' ORDER BY MailingState ASC ';
      }
      search();
    }
    
    public void sortByCountry () {
      if (sortOrder == ' ORDER BY MailingCountry ASC ') {
        sortOrder = ' ORDER BY MailingCountry DESC ';
      }
      else {
        sortOrder = ' ORDER BY MailingCountry ASC ';
      }
      search();
    }
    
    public void sortById () {
      if (sortOrder == ' ORDER BY ID ASC ') {
        sortOrder = ' ORDER BY ID DESC ';
      }
      else {
        sortOrder = ' ORDER BY ID ASC ';
      }
      search();
    }
}