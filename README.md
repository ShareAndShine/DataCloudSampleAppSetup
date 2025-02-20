Data Ingestion:
===============

a. Source:CRM | Obj: Contact 
		- update field level permissions for Contacts object, custom fields External ID and RAVG Retail Membership Number, RAVG_Retail_Points_Balance__c enabling Read Access
		- Update the RAVG Retail Membership Number Field Label to  Retail Membership Number & RAVG_Retail_Membership_Number_c Field API Name to  Retail_Membership_Number_c
		- Update the RAVG Retail Points Balance Field Label to Retail Points Balance & RAVG_Retail_Points_Balance__c Field API Name to Retail_Points_Balance__c
		- Add 3 new formula fields
			- Identification Name | Should return static text "Retail Membership"
			- Identification Type | Should return static text "Loyalty Program"
			- Birth Date | Should return date | Extract value from BirthDate Std. field

b. Source:CRM | Obj: Case
		- update field level permissions for Case object, custom field ParentID enabling Read Access
		- Create new formula field  "Action Priority" on case object | return type - Text		\
				IF(sourceField['IsEscalated'] == "true"
				  , IF(
					  sourceField['Priority'] == "High", "P1 - Escalated High",  IF(
					  sourceField['Priority'] == "Medium", "P3 - Escalated Medium", "P4 - Escalated Low"
				  ))
				  , IF(
					  sourceField['Priority'] == "High", "P2 - High",  IF(
					  sourceField['Priority'] == "Medium", "P5 - Medium", "P6 - Low"  
				  ))
				)


c. Source:CRM | Bookings
		- Remove Last Modified By ID and Last Referenced Date fields
		- Create new formula field  "Purpose" with return type - Text
			IF(
			  AND(sourceField['Is_Leisure__c'] == "true", sourceField['Is_Business__c'] == "true")
			  , "Mixed"
			  , IF(
				AND(sourceField['Is_Leisure__c'] == "true", sourceField['Is_Business__c'] == "false")
				, "Personal"
				, IF (
				  AND(sourceField['Is_Leisure__c'] == "false", sourceField['Is_Business__c'] == "true")
				  , "Business"
				  , "Unspecified"
				)
			  )
			)

d. Source:CRM | Rental
		- Check: Update field level permission so that all fields can be read by Data Cloud Salesforce Connector
		- Create new formula field  "Purpose" with return type - Text
			IF(
			  AND(sourceField['Is_Leisure__c'] == "true", sourceField['Is_Business__c'] == "true")
			  , "Mixed"
			  , IF(
				AND(sourceField['Is_Leisure__c'] == "true", sourceField['Is_Business__c'] == "false")
				, "Personal"
				, IF (
				  AND(sourceField['Is_Leisure__c'] == "false", sourceField['Is_Business__c'] == "true")
				  , "Business"
				  , "Unspecified"
				)
			  )
			)
		- Create new formula field  "Combined Children Seat Count" with return type - Number
			NUMBER(sourceField['Baby_Seat_Count__c']) + NUMBER(sourceField['Booster_Seat_Count__c'])


e. Source:CRM | Rental Preference
		- Rename Field label 
				- Leisure - Protection Coverage  to Leisure - Protection Coverage - Source
				- Business - Protection Coverage to Business - Protection Coverage - Source
		- Introduce  new formula field  "Leisure - Protection Coverage" with return type - Number
				- IF(ISEMPTY(sourceField['Leisure_Protection_Coverage__c']), "NONE", sourceField['Leisure_Protection_Coverage__c'])
		- Create new formula field  "Business - Protection Coverage" with return type - Number
				- IF(ISEMPTY(sourceField['Business_Protection_Coverage__c']), "NONE", sourceField['Business_Protection_Coverage__c'])
		- Check if data type for the fields "Leisure Preferences Last Updated Date" and "Business Preferences Last Updated Date" are date, else use formula and change to date
		
 f. Source: S3 | Customer
		- Create new formula field  "Party Identification Id" with return type text		
			- CONCAT("LoyaltyProgram_RetailMembership_", sourceField['Customer Ref Number'])
		- Create new formula field  "Party Identification Type" with return type text and hardcode value "Retail Membership"
		- Create new formula field  "Contact Point Email Id" with return type text		
			- CONCAT(sourceField['Customer Ref Number'], "_ContactPointEmail_", sourceField['Email'])
		- Check data type of email field  , if its not of "Email" ->  update type to Email

e. Source: S3 | Order Header
		- Check data type of customer number field  , if its not of "Text" ->  update type to Text
		- Create new formula field  "Internal Business Unit" with return type text and hardcode value "eComm_OutdoorAdventure_Online_Retail"


f. Source: S3 | Order Detail
		- Check data type of SKU field  , if its not of "Text" ->  update type to Text
		- Check data type of Order Number field  , if its not of "Text" ->  update type to Text
		- Check data type of Order Line Number field  , if its not of "Text" ->  update type to Text
		- Create new formula field  "Order Line Primary Key" with return type text 
			- CONCAT(sourceField['Order Number']+'_'+ sourceField['Order Line Number'])
