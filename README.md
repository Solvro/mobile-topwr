# ToPWR

![ToPWR file cover](/assets/topwr_header.png) 
## 🇵🇱
ToPWR to aplikacja mobilna stworzona przez studentów dla studentów Politechniki Wrocławskiej. Licznik dni do sesji, mapka kampusu, informacje o dziekanatach, kółkach naukowych i licznik wolnych miejsc parkingowych na żywo - wszystko, co trzeba w jednym miejscu. Life made easy. 🚀

ToPWR to efekt naszych doświadczeń i pomysłów, którymi chcielibyśmy się podzielić z innymi studentami. Bo przecież każdy z nas zaczynał od zera, więc dlaczego by nie stworzyć czegoś, co ułatwiłoby życie na uczelni? Zależało nam, żeby każdy student miał w kieszeni takiego kumpla, co go wspiera i pomaga ogarnąć to wszystko. Bo studia to nie tylko nauka, to też odkrywanie, poznawanie, czasem trochę gubienie się i to jest w porządku.

## 🇬🇧 
ToPWR is a mobile application created by students for students of Wrocław University of Science and Technology. A countdown to exams, a campus map, information about dean's offices, student science clubs and live free parking places counter – everything you need in one place. Life made easy. 🚀

ToPWR is the result of our experiences and ideas that we want to share with other students. After all, each of us started from scratch, so why not create something that would make university life easier? We wanted every student to have a friend in their pocket, supporting and helping them manage everything. Because university is not just about studying; it's also about discovering, meeting new people, sometimes getting a little lost, and that's okay.

## Technologies used
- Flutter
- Riverpod
- Freezed
- graphql_codegen
- Dio
- google_maps_flutter
- fl_chart

## Links

- ToPWR Figma: https://www.figma.com/file/33ofdGYbBzWvDi2MabxIc1/ToPWR-(imported)?type=design&node-id=2%3A2091&mode=design&t=qILflhzpbN8xW8F6-1

## Development

1. ### Google maps API key

   There are google maps api keys already defined, but their usage is restricted on Google Maps Panel to specific package/bundle ids.

   #### Android only

   On Android, apart from package id, restriction is for specific signing key's SHA1 fingerprints. So to test on Android, your debug signing key's fingerprint must be added to the maps panel. (Contact @simon-the-shark to include yours)

   Web key is restricted for localhost usage only

2. ### Before you start, you need to add `.env` file to project's root with appropriate content:

```bash
API_URL="https://<our-server-url>/graphql"
API_KEY="<Your api token>"
IPARKING_URL="https://<secret parking's source>.pl"
```

3.  ### Code generation
    Some of app's dependecies utilize code generation feature and generated files **are not currently included** to control version and this github repository, so before building, running or developing application, it's crucial to run code generation (to generate all needed files) in terminal with:

- For one-time generation:

```zsh
dart run build_runner build
```

**OR**

- For watch mode and continous necessary rebuilds after every change to connected files (usufull for development):

```zsh
dart run build_runner watch
```

4.  ### It's now possible to run or build the app in the usual way
    _Rebuilds are necessary after any updates or changes to affected files (`watch` command does it for you)_

#### Additional notes:

1. App's custom theme usage instructions: https://github.com/Solvro/topwr-mobile/tree/main/lib/theme
2. Introductions to internationalizing flutter apps (making them available in different languages): https://docs.flutter.dev/ui/accessibility-and-internationalization/internationalization
3. Api helper module instructions: https://github.com/Solvro/topwr-mobile/tree/main/lib/api_base

## Working with git

### SSH

Connecting to Github(Gh) repository via SSH on Windows, tutorial: https://www.youtube.com/watch?v=vExsOTgIOGw

### Building new feature

1. git checkout main -> checkout main branch
2. git pull origin main -> pull current changes from main branch
3. git fetch -> be up to date with remote branches
4. git checkout -b MOBILE-x_my_feature_branch -> x - stands for issue number; it is going to checkout and create new branch name MOBILE-x_my_feature_branch
   (... working on the feature, we are still on our branch named MOBILE-x_my_feature_branch)
5. git add . -> add all changes we have made
6. git commit -m "My changes description" -> commit made changes with proper description
7. git push origin MOBILE-x_my_feature_branch -> pushing our changes to remote branch
8. On Github we are going to make Pull Request (PR) from our remote branch

### Remarks

- Do not push directly to main branch!!! This is bad practice!
- local branch - is our branch on our computer not on the server if we do some chagnes and do checkout to diffrent branch without saving them(commiting) we might loose them, commit before checkout to different branch!
- remote branch - this is branch with our code in github's servers
- After code review which was successful, we can merge from our feature branch to main branch. After merging we should clean after ourself.

1. git branch -d MOBILE-x_my_feature_branch -> deletes our local branch
2. git push origin --delete MOBILE-x_my_feature_branch -> delete our remote branch
