// Use .apex files to store anonymous Apex.
// You can execute anonymous Apex in VS Code by selecting the
//     apex text and running the command:
//     SFDX: Execute Anonymous Apex with Currently Selected Text
// You can also execute the entire file by running the command:
//     SFDX: Execute Anonymous Apex with Editor Contents

//CleanUpInitialDataAction.performCleanUp();
GenerateAccountAndAssetsDCSample.generateAccountAndAssets();
GenerateContactsDCSample.generateContacts();
GenerateRentalPrefDCSample.generateRentalPreferences();

// Bookings
GenerateBookingsDCSample.generateBookings();

// Rentals
GenerateRentalsDCSample.generateRentals();

// Cases
GenerateCasesDCSample.generateCases();  

/*SetupData.TriggerSampleData();

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
        */