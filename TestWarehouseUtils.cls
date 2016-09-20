@isTest
private class TestWarehouseUtils {
    
    // test that we find only warehouses that are within 20 miles
    static testMethod void testFindWarehousesWithinTwentyMiles () {
        // Salesforce HQ
        String myLat = '37.793731';
        String myLon = '-122.395002';
        
        // Create test warehouse data
        Warehouse__c closestWarehouse = createClosestTestWarehouse();
        Warehouse__c closeWarehouse = createCloseTestWarehouse();
        Warehouse__c tooFarWarehouse = createTooFarTestWarehouse();
        
        // Perform the test execution
        Test.startTest();
        List<Warehouse__c> nearbyWarehouses = WarehouseUtils.findNearbyWarehouses(myLat, myLon);
        Test.stopTest();
        
        // Make assertions about expected results
        // We expect two warehouses
        System.assert(nearbyWarehouses.size() == 2);
        // We expect two SPECIFIC warehouses, in order of proximity
        System.assert(nearbyWarehouses[0].Name == closestWarehouse.Name);
        System.assert(nearbyWarehouses[1].Name == closeWarehouse.Name);
        // We do NOT expect to see the warehouse that's too far away
        if(0 < nearbyWarehouses.size()) {
            for (Warehouse__c wh : nearbyWarehouses) {
                System.assert(wh.Name != tooFarWarehouse.Name);
            }
        }  
    }
    
    // test that we don't find anything when further than 20 miles
    static testMethod void testDontFindWarehousesFurtherThanTwentyMiles() {
        
        // Eiffel Tower, Paris, France
        String myLat = '48.85837';
        String myLon = '2.294481';
        
        // Create test warehouse data
        Warehouse__c closestWarehouse = createClosestTestWarehouse();
        Warehouse__c closeWarehouse = createCloseTestWarehouse();
        Warehouse__c tooFarWarehouse = createTooFarTestWarehouse();
        // Perform the test execution
        Test.startTest();
        List<Warehouse__c> nearbyWarehouses = WarehouseUtils.findNearbyWarehouses(myLat, myLon);
        Test.stopTest();
        
        // We expect to see NO warehouses
        System.assert(nearbyWarehouses.size() == 0);
    }
    
    // test that we use a default location if the lat or long is invalid
    static testMethod void testFindWarehousesDefaultLocation() {
        // Trigger the default location, which should be SF
        String myLat = null;
        String myLon = null;
        
        // Create test warehouse data
        Warehouse__c closestWarehouse = createClosestTestWarehouse();
        Warehouse__c closeWarehouse = createCloseTestWarehouse();
        Warehouse__c tooFarWarehouse = createTooFarTestWarehouse();
        
        // Perform the test execution
        Test.startTest();
        List<Warehouse__c> nearbyWarehouses = WarehouseUtils.findNearbyWarehouses(myLat, myLon);
        Test.stopTest();
        
        // Make assertions about expected results
        // We expect two warehouses
        System.assert(nearbyWarehouses.size() == 2);
        // We expect two SPECIFIC warehouses, in order of proximity
        System.assert(nearbyWarehouses[0].Name == closestWarehouse.Name);
        System.assert(nearbyWarehouses[1].Name == closeWarehouse.Name);
        // We do NOT expect to see the warehouse that's too far away
        if(0 < nearbyWarehouses.size()) {
            for (Warehouse__c wh : nearbyWarehouses) {
                System.assert(wh.Name != tooFarWarehouse.Name);
            }
        }
    }
    
    // test the class constructor
    static testMethod void testClassConstructor() {
        Test.startTest();
        WarehouseUtils utils = new WarehouseUtils(null);
        Test.stopTest();
        // We expect that utils is not null
        System.assert(utils != null);
    }
    
    // helper methods to create test data
    static Warehouse__c createTestWarehouse(String name, Decimal lat, Decimal lon) {
        Warehouse__c w = new Warehouse__c(
            Name = name,
            Location__Latitude__s = lat,
            Location__Longitude__s = lon
        );
        insert w;
        return w;
    }
    
    static Warehouse__c createClosestTestWarehouse() {
        // Federal Reserve Bank of SF, next door to Salesforce HQ
        return(createTestWarehouse('Warehouse1', 37.7927731, -122.4010922));
    }
    
    static Warehouse__c createCloseTestWarehouse() {
        // Moscone Center, home of Dreamforce
        return(createTestWarehouse('Warehouse2', 37.783944, -122.401289));
    }
    
    static Warehouse__c createTooFarTestWarehouse() {
        // Mount Rushmore, South Dakota
        return(createTestWarehouse('TooFarWarehouse', 43.879102, -103.459067));
    }
}