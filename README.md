# ToPWR

![ToPWR file cover](/assets/png/topwr_header.png)

## PL

ToPWR to aplikacja mobilna stworzona przez studentów, dla studentów Politechniki Wrocławskiej. Licznik dni do sesji, informacje o zmianach w kalendarzu akademickim, mapka kampusu, baza wiedzy o dziekanatach, wydziałach, kierunkach i kołach naukowych, menu i podgląd zapełnienia SKS-u na żywo, przydatne poradniki oraz licznik wolnych miejsc parkingowych - wszystko, co trzeba, w jednym miejscu. Life made easy. 🚀

ToPWR to efekt naszych doświadczeń i pomysłów, którymi chcielibyśmy się podzielić z innymi studentami. Bo przecież każdy z nas zaczynał od zera, więc dlaczego nie stworzyć czegoś, co ułatwiłoby życie na uczelni? Zależało nam, aby każdy student miał w kieszeni takiego kumpla, który go wspiera i pomaga ogarnąć to wszystko. Bo studia to nie tylko nauka, to także odkrywanie, poznawanie, czasem trochę gubienie się - i to jest w porządku.

Co ważne, projekt jest w pełni open-source! Udostępniamy nasz kod, aby ułatwić wzajemną naukę, wspierać rozwój i budować zaufanie wewnątrz społeczności Politechniki Wrocławskiej.

## EN

ToPWR is a mobile application created by the students, for the students of Wrocław University of Science and Technology. A countdown to exams, information about changes in the academic calendar, a campus map, a knowledge base about dean's offices, faculties, fields of study, and student science clubs, the SKS menu and a live crowd preview, useful guides, and a live counter for available parking spots – everything you need in one place. Life made easy. 🚀

ToPWR is the result of our experiences and ideas, which we want to share with other students. After all, each of us started from scratch, so why not create something that makes university life easier? We wanted every student to have a companion in their pocket, supporting and helping them manage everything. Because uni life is not just about studying; it's also about discovering, meeting new people, sometimes getting a little lost, and that's okay.

Importantly, the project is fully open-source! We share our code to facilitate mutual learning, support development, and build trust within the community of Wrocław University of Science and Technology.

## Project history

The app was initially created by KN Solvro members using native mobile technologies (Android & iOS) and a Strapi backend in 2022 (`v0.5.1` was released on October 3, 2022).

Subsequently, our team began a complete redesign and overhaul, transitioning to Flutter and Directus CMS. This led to the launch of version `v1.0.0` on September 26, 2024. 🚀

At the beginning of 2025, our organization was designated a Strategic Science Club at Wrocław Tech, with this app serving as our flagship project.

We have consistently improved and expanded the platform over the years. We are currently migrating to a custom backend and admin panel while continuously adding new features.

Version `v2.0.0` is expected to be released in the coming months.

## Current team

- [@simon-the-shark](https://github.com/simon-the-shark) - Flutter Techlead
- [@odominiak](https://github.com/odominiak) - Product Owner / QA
- [@tomasz-trela](https://github.com/tomasz-trela) - Flutter Developer
- [@24bartixx](https://github.com/24bartixx) - Flutter Developer
- [@simplyNoOne](https://github.com/simplyNoOne) - Flutter Developer
- [@BombardierBulge](https://github.com/BombardierBulge) - Flutter Developer
- [@MarmoPL](https://github.com/MarmoPL) - Flutter Developer
- [@MaksymilianMazurkiewicz](https://github.com/MaksymilianMazurkiewicz) - Flutter Developer
- [@s4n000](https://github.com/s4n000) - Project Manager
- [@Infor-Tech](https://github.com/Infor-Tech) - Junior Project Manager

We're using many UI/UX designs and graphic assets created by [@domkakromka](https://github.com/domkakromka), [@AniaM727](https://github.com/AniaM727)

## Technologies used

- Flutter
- Riverpod
- Freezed
- graphql_codegen (previously)
- Dio
- fl_chart
- wiredash
- lottie
- Drift (sqlite)
- Microsoft Clarity
- bugsink
- fastlane

## Links

[![docs.solvro.pl](https://i.imgur.com/fuV0gra.png)](https://docs.solvro.pl/guides/flutter-mobile)

- https://www.figma.com/file/33ofdGYbBzWvDi2MabxIc1/ToPWR-(imported)?type=design&node-id=2%3A2091&mode=design&t=qILflhzpbN8xW8F6-1
- https://solvro.pwr.edu.pl/blog/fix-flutter-android-back-btn

## Repobeats
![Repobeats charts stats](https://repobeats.axiom.co/api/embed/4638a3f84487a49678958c6589e5877e10baf744.svg "Repobeats analytics image")
  
## Star History

[![Star History Chart](https://api.star-history.com/svg?repos=Solvro/mobile-topwr&type=Date)](https://star-history.com/#Solvro/mobile-topwr&Date)


# Development
Check in pubspec.yaml

### For secrets storing, we're using [git-crypt](https://github.com/AGWA/git-crypt). You need to:
1. Pull the repo
2. Install git-crypt: https://github.com/AGWA/git-crypt/blob/master/INSTALL.md
3. Get our cryptographic key
4. Run `git-crypt unlock <<name-of-the-key>>`

  ### Code generation
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

- If something doesn't build correctly, this might help:

```zsh
dart run build_runner build -d
```

### It's now possible to run or build the app in the usual way
    _Rebuilds are necessary after any updates or changes to affected files (`watch` command does it for you)_
   - Either with your IDE or
   - From Terminal:
   ```bash
   flutter run
   ```



### **[OPTIONAL]** If you operate on many Flutter versions, we recommend `fvm` Flutter version manager: https://fvm.app/
```bash
fvm dart run build_runner watch
fvm flutter run
// etc...
```
    

### Additional notes:

1. Introductions to internationalizing flutter apps (making them available in different languages): https://docs.flutter.dev/ui/accessibility-and-internationalization/internationalization
2. We use `flutter_gen` for generating asset paths: https://pub.dev/packages/flutter_gen 
3. For unified names read and follow: [taxonomy.md](./taxonomy.md)
4. For navigation we use `auto_route`, docs here: https://pub.dev/packages/auto_route - but the setup is a bit crazy and fragile so we advise against tinkering with it whenever possible.

# Before you push a commit
- Run the linter
```bash
flutter analyze
```
- If you have any problems listed, try to autofix with
```bash
dart fix --apply
```
- Run `analyze` again, if problems still persist, correct them manually. If you disagree with some of the rules, we can still discuss and adjust them. Hit me up [@simon-the-shark](https://github.com/simon-the-shark) or open an issue.
- Run formatter
```bash
dart format .
```
- Run riverpod linter (and any other custom lint package)
```bash
dart run custom_lint
```

## Github workflow
Don't worry if you've forgotten about the steps, automatic gh action will run the checks for you and notify if somthing's wrong.

## Husky 
We have husky hooks, but you have to install them once:
```
dart run husky install
```

## Working with git

### Github Solvro Handbook 🔥

https://docs.solvro.pl/guides/github
