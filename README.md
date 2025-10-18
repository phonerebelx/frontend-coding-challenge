🚀 Crewmeister Absence Manager — Flutter Implementation

Author: Syed Abdul Ali
Challenge Source: Crewmeister Frontend Coding Challenge
Tech Stack: Flutter, GetX, MVVM Architecture, Dart

🧩 Overview

This project is my Flutter-based implementation of the Crewmeister Frontend Coding Challenge, focusing on the Absence Manager feature.
The goal of this exercise was to demonstrate my ability to design, structure, and develop a clean, performant, and testable Flutter application that follows best practices and delivers an excellent user experience.

📱 App Features

✅ Absence List View
Displays a list of employee absences including:
Member name
Type of absence
Period
Member note
Status (Requested / Confirmed / Rejected)
Admitter note

✅ Pagination
Loads 10 absences per page.
Supports infinite scrolling and dynamic page loading.

✅ Filtering
Filter absences by:
Type (Sick Leave, Vacation)
Date Range

✅ States Handling
Loading state with global loader.
Empty state for no results.
Error state with retry option.

✅ (Bonus) iCal Export
Generate and export absences as .ics calendar files, importable into Outlook or Google Calendar.

🧠 Architecture & Tech Stack

| Layer                    | Description                                          |
| ------------------------ | ---------------------------------------------------- |
| **Architecture Pattern** | MVVM (Model–View–ViewModel)                          |
| **State Management**     | GetX                                                 |
| **Network / Data**       | Repository pattern for clean data flow               |
| **Pagination**           | Custom implementation via `AbsencesPagingController` |
| **Testing**              | Unit tests using `flutter_test`                      |
| **Error Handling**       | Centralized via `Status` model                       |
| **UI Framework**         | Flutter Widgets and Material components              |

🧪 Unit Testing

This project includes comprehensive unit tests to ensure correctness of business logic and controller/repository behavior.

✅ absence_controller_test.dart
* Verifies mapping between UI display names and internal type codes.
* Ensures all leave type keys are returned correctly.

✅ absences_paging_repository_test.dart
* Tests repository pagination logic (fetchAbsencesPage with paging).
* Validates filtering behavior by absence type.
* Ensures refresh/reset behavior correctly updates state (currentPage, isLastPage, and absences list).

All tests are written using the flutter_test package and GetX test mode to simulate controller behavior without relying on Flutter widgets.


⚙️ Project Setup & Run Instructions

1️⃣ Clone the repository:
git clone https://github.com/phonerebelx/frontend-coding-challenge.git
cd frontend-coding-challenge

2️⃣ Install dependencies:
flutter pub get

3️⃣ Run the app:
flutter run

4️⃣ Run tests
flutter test

🧰 Folder Structure

lib/
 ├── assets/               # Images, icons
 ├── json_files/           # Mock JSON data for absences & members
 ├── network/              # API response & status handling
 ├── models/               # Data models (Payloads, DisplayItems)
 ├── repository/           # Data repositories (pagination, employee)
 ├── res/                  # App resources (colors, strings, styles)
 ├── utils/                # Utilities (iCal generator, date helpers)
 ├── view/                 # Screens and widgets
 ├── viewmodels/           # Controllers (GetX)
 └── main.dart             # Entry point
test/
 ├── controllers/               # Controller unit tests
 ├── repositories/              # repository unit tests

🧩 Highlights

* Follows Clean Architecture principles.
* Modular, easily maintainable codebase.
* Proper test coverage for core logic.
* Strong emphasis on state management, error handling, and UI consistency.
* Bonus feature: iCal file export.

🧑‍💻 About the Developer

I’m Syed Abdul Ali, a Senior Android & Flutter Developer with over 3 years of experience building scalable and maintainable mobile apps.
This project reflects my approach to clean architecture, performance optimization, and test-driven development.
📧 Email: ali962001@gmail.com
🌐 GitHub: [phonerebelx](https://github.com/phonerebelx)

💬 Acknowledgment

Challenge and mock data provided by Crewmeister GmbH.
This project is solely for demonstrating coding skills as part of their Frontend Flutter Developer assessment.
