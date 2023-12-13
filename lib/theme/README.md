# Theme for ToPWr project

Defines Colors and TextStyles for project with `ThemeExtension`s.

# Usage

# Colors

```dart
// To access AppColorTheme object:
context.colorTheme

// To access some color's value:
context.colorTheme.orangePomegranade
```

#### Available fields in `AppColorTheme`:

```dart
HexColor blackMirage            // Mirage #293241
HexColor whiteSoap              // Soap #FFFDFC
HexColor orangePomegranade      // Pomegranade #E43D32
HexColor greyPigeon             // Pigeon #77859D
HexColor greyLight              // Grey #F7F7F8
HexColor blueAzure              // Azure #3F6499
LinearGradient toPwrGradient    // ToPwr LinearGradient #f67448, #ee6645, #df371b
```

Colors are of custom type `HexColor`, which is subtype of Flutter's standard `Color`, so can be used anywhere in the framework without any conversion.

# Typography - TextStyles

```dart
// To access AppTextTheme object:
context.textTheme

// To access some text style:
context.textTheme.boldBodyOrange
```

#### Available fields in `AppTextTheme`:

Object has defined text styles used anywhere in the design project:  
_All text styles use `Rubik` font and 1.2 line height scale_

```dart
    TextStyle headline          // fontSize: 17px, weight: w500, blackMirage
    TextStyle headlineWhite     // fontSize: 17px, weight: w500, whiteSoap

    TextStyle title             // fontSize: 15px, weight: w500, blackMirage
    TextStyle titleWhite        // fontSize: 15px, weight: w500, whiteSoap
    TextStyle titleGrey         // fontSize: 15px, weight: w500, grayPigeon
    TextStyle titleOrange       // fontSize: 15px, weight: w500, orangePomegranade

    TextStyle body              // fontSize: 13px, weight: w400, blackMirage
    TextStyle bodyWhite         // fontSize: 13px, weight: w400, whiteSoap
    TextStyle bodyGrey          // fontSize: 13px, weight: w400, grayPigeon

    TextStyle lightTitle        // fontSize: 15px, weight: w400, blackMirage
    TextStyle lightTitleOrange  // fontSize: 15px, weight: w400, orangePomegranade

    TextStyle boldBody          // fontSize: 13px, weight: w500, blackMirage
    TextStyle boldBodyOrange    // fontSize: 13px, weight: w500, orangePomegranade
```

# HexColor

This class extends Flutter'a standard `Color`, so can be used anywhere in the framework without special conversion, however if needed provides from and to hexadecimal string conversion:

#### To hex string conversion:

```dart
context.colorTheme.orangePomegranade.hexString // returns "#e43d32"
```

#### From hex string conversion:

```dart
// creates Flutter's color from hex string. HOVEWER can't be declared as **const** value
HexColor("#e43d32")

// For const decralation, there's named constructor, which delegates to default Color constructor
const HexColor.consts(0xFFE43D32) // same sa const Color(0xFFE43D32)
```
