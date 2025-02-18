public with sharing class SetupData {
    public SetupData() {

    }

    public static void TriggerSampleData() {

        // Clean up existing data
        CleanUpInitialDataAction.performCleanUp();

        // Accounts & Assets
        GenerateAccountAndAssetsDCSample.generateAccountAndAssets();
        
        // Contacts
        GenerateContactsDCSample.generateContacts();

        // Rental Preferences
        GenerateRentalPrefDCSample.generateRentalPreferences();
        // Bookings
        GenerateBookingsDCSample.generateBookings();

        // Rentals
        GenerateRentalsDCSample.generateRentals();

        // Cases
        GenerateCasesDCSample.generateCases();        
    }
}