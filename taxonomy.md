# ToPwr Developer Taxonomy: In-Code Naming Conventions

Due to multiple split conventions and absurdly diverse names for similar entities in our group project, here is our unified naming dictionary to use while coding this app.

## Purpose
This guide defines what to call classes, variables, folders (everything) in the codebase for consistency and ease of collaboration among developers.

**Example:**  
Use `ScienceClubsView` or `scienceClubsRepository` consistently in the codebase instead of alternatives like `scienceCircle` or `studentResearchGroup`.

## General Rules
1. Opt for simplicity and shorter names while conveying as much information as possible.
2. Use singular and plural forms appropriately (e.g., `Department` and `Departments` when most appropriate).

## Entities
Even if backend names differ, use these names on the Flutter side:
- Building
- Parking
- Department (widely used in the codebase, though not the most accurate translation)
- Science Club
- Guide
- Academic Calendar
- Contact Icons
- News (coming soon)

*If any important entity is missing, add it with your PR.*

## Widgets/Views
Not related to actual data entities, but more widget-oriented names that have had multiple variations and are now unified.

- Home/HomeView
- AboutUs/AboutUsView
- SplashScreen
- CountDown
- DateChip
- BigPreviewCard
- WideTileCard
- SearchBox

## Views
For all main pages (the ones you want to generate navigation routes for), use: `XView`
- Example: `HomeView`, `ScienceClubsView`, `ScienceClubDetailView`
- Avoid: ~~HomeScreen, HomePage~~

This is configured for `auto_route` generator to create route objects.

## Detail Views
For list views and their corresponding detail views, use `XsView` and `XDetailView`
- Example: `ScienceClubsView` and `ScienceClubDetailView`

### Details Models
For models used in DetailView, use `XDetails`
- Example: `DepartmentDetails`

## Features Folders
1. If a feature is a view, name it accordingly: `departments_view` or `department_detail_view`.
2. If a feature is not view-oriented, use a simple, descriptive keyword: `academic_calendar`, `navigator`, `parking_chart`.

## Extensions
For all `extensions`, append `X` in the name.
```dart
extension ReverseIteratorX<T> on DoubleLinkedQueue<T>{
    Iterable<T> get reverseIterator sync* {
        // ...
    }
}
