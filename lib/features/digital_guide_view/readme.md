# Requirements
* Two variables should be added to .env
  * DIGITAL_GUIDE_URL
  * DIGITAL_GUIDE_AUTHORIZATION_TOKEN
  * DIGITAL_GUIDE_URL   (no token required)

# Tips
* All HTTP requests must include the authorization token ("Token ${Env.digitalGuideAuthorizationToken"})
* The complete list of endpoints is available after logging under [this](https://przewodnik.pwr.edu.pl/swagger/) link

# Used endpoints
1) Building data and image
  * /general_info/data/repository/digita_guide_repository.dart
  * DIGITAL_GUIDE_URL/buildings/{id}
  * DIGITAL_GUIDE_URL/images/{id}
2) Surroundings data
  * tabs/surrounding/data/repository/surrounding_repository.dart
  * DIGITAL_GUIDE_URL/surroundings/{id}
3) Micronavigation data
  * /tabs/micronavigation/data/repository/micronavigation_repository.dart
  * DIGITAL_GUIDE_URL_MICRONAVIGATION/beaconplus/?location={external_id}
  * Note that endpoint above is different than usual one and uses external_id from digital_guide_response. Additionaly it is unprotected, so for now it is not being added to .env