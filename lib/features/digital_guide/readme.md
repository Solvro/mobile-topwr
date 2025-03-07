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
  * /general_info/data/repository/digital_guide_repository.dart
  * DIGITAL_GUIDE_URL/buildings/{id}
  * DIGITAL_GUIDE_URL/images/{id}
2) Surroundings data
  * tabs/surrounding/data/repository/surrounding_repository.dart
  * DIGITAL_GUIDE_URL/surroundings/{id}

3) Micronavigation data
  * /tabs/micronavigation/data/repository/micronavigation_repository.dart
  * DIGITAL_GUIDE_ADDONS_URL/beaconplus/?location={external_id}

4) Rooms data
  * /rooms/data/repository/rooms_repository.dart
  * DIGITAL_GUIDE_URL/rooms/{id}

5) Lodges data
  * /lodges/?building={buildingId}

6) Dressing rooms data
  * /dressing_rooms/?building={buildingId}

7) Lifts data
* /lifts/?building={buildingId}

8) Localization data
  * /localization/data/repository/localization_repository.dart
  * DIGITAL_GUIDE_URL/buildings/{location_map}
  * DIGITAL_GUIDE_URL/images/{id}
