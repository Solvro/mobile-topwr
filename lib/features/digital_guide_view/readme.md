# Requirements
* Two variables should be added to .env
  * DIGITAL_GUIDE_URL
  * DIGITAL_GUIDE_AUTHORIZATION_TOKEN

# Tips
* All HTTP requests must include the authorization token ("Token ${Env.digitalGuideAuthorizationToken"})
* The complete list of endpoints is available after logging under [this](https://przewodnik.pwr.edu.pl/swagger/) link

# Used endpoints
1) Building data and image
  * /general_info/data/repository/digital_guide_repository.dart
  * DIGITAL_GUIDE_URL/buildings/{id}
  * DIGITAL_GUIDE_URL/images/{id}
2) Surroundings data
  * /surrounding/data/repository/surrounding_repository.dart
  * DIGITAL_GUIDE_URL/surroundings/{id}
3) Rooms data
  * /rooms/data/repository/rooms_repository.dart
  * DIGITAL_GUIDE_URL/rooms/{id}
