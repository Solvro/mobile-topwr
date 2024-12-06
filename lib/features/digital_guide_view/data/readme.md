# Requirements
* All HTTP requests must include the authorization token (DIGITAL_GUIDE_URL)

# Tips
* To obtain the authorization token, username, or password for API login, please contact the development team
* The complete list of endpoints is available after logging under https://przewodnik.pwr.edu.pl/swagger/

# Used endpoints and providers
1) Building data
  * DIGITAL_GUIDE_URL/buildings/{id}
  * Used via: getDigitalGuideDataProvider({id})
2) Building image
  * DIGITAL_GUIDE_URL/images/{id}
  * Used via: getImageDataProvider({id})
