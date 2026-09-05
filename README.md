# 🥗 Mealist.ai — AI-Powered Recipe & Meal Planner

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-3.x-02569B?style=for-the-badge&logo=flutter&logoColor=white" />
  <img src="https://img.shields.io/badge/Dart-3.x-0175C2?style=for-the-badge&logo=dart&logoColor=white" />
  <img src="https://img.shields.io/badge/GetX-State_Management-8B0000?style=for-the-badge" />
  <img src="https://img.shields.io/badge/Version-1.0.0-2D5F4F?style=for-the-badge" />
  <img src="https://img.shields.io/badge/Platform-iOS%20%7C%20Android-lightgrey?style=for-the-badge" />
</p>

> **Mealist.ai** is a premium AI-driven meal planning and pantry management application built with Flutter. It intelligently suggests recipes based on what you already have, adapts meal portions to your household members' dietary needs and allergen restrictions, and keeps your pantry, shopping list, and weekly plan perfectly in sync.

---

## ✨ Features at a Glance

| Feature | Description |
|---|---|
| 🧠 **AI Recipe Suggestions** | Ask Mealist.ai anything — get personalized recipes from your pantry ingredients |
| 🥦 **Smart Pantry Tracking** | Manage Fridge, Freezer & Pantry items with expiry dates and urgency alerts |
| 👨‍👩‍👧 **Household Profiles** | Per-member dietary tags, allergen filters, and auto-scaled portion sizes |
| 🛡️ **Family Safety Shield** | Automatic allergen filtering across all recipe suggestions for every household member |
| 📅 **Meal Planning** | Plan meals for the week with drag-and-drop scheduling |
| 🛒 **Shopping List** | Auto-generate lists from missing recipe ingredients with shopping mode |
| 🍳 **Cook Mode** | Step-by-step guided cooking with timers and hands-free navigation |
| 🌍 **Explore & Discover** | Browse cuisines, get surprised with new recipes, and explore trending dishes |
| 📊 **Nutrition Insights** | Track calories, macros, and progress toward your personal health goals |
| 🔗 **Recipe Import** | Import recipes instantly from any URL or create your own with the recipe wizard |

---

## 📱 Screenshots

> The app follows a warm cream (`#F5F3EE`) and deep forest green (`#2D5F4F`) design language — premium, clean, and inviting.

| Pantry | Add to Pantry | What Can I Cook | Item Details |
|---|---|---|---|
| Manage your Fridge, Freezer & Pantry | Quick-add with search, quantity stepper, unit & use-by date | Household-aware recipe suggestions with safety filtering | Full item view with editable quantity, storage & expiry |

---

## 🏗️ Architecture

Mealist.ai is built with a clean, scalable **feature-first modular architecture** using the **GetX** pattern for state management, dependency injection, and navigation.

```
lib/
├── core/
│   ├── constants/         # AppColors, AppTextStyles, AppSpacing, AppRadius
│   ├── services/          # API clients, local storage, etc.
│   └── theme/             # ThemeData configuration
│
├── modules/               # Feature modules (each self-contained)
│   ├── auth/              # Welcome, Sign In, Register, Forgot Password
│   ├── onboarding/        # Dietary prefs, cuisines, allergies, household, goals
│   ├── main_shell/        # Bottom nav shell with 5 tabs
│   ├── home/              # Home dashboard with nutrition ring & meal cards
│   ├── pantry/            # Pantry management, search, item details, what can I cook
│   ├── recipes/           # Recipe details, add recipe, import from URL, wizard
│   ├── plan/              # Weekly meal planner
│   ├── explore/           # Cuisine discovery and surprise recipes
│   ├── shopping/          # Shopping list and shopping mode
│   ├── cook_mode/         # Step-by-step guided cooking
│   ├── ask_mealist/       # AI chat interface for recipe & meal questions
│   ├── profile/           # Goals, nutrition targets, allergies, preferences
│   └── splash/            # Animated splash screen
│
├── routes/
│   ├── app_routes.dart    # All named route constants
│   └── app_pages.dart     # GetPage registry with bindings
│
└── shared/
    ├── bindings/          # Shared GetX bindings
    ├── common_widgets/    # Reusable UI components
    └── controllers/       # Cross-module shared controllers
```

Each module follows the **Binding → Controller → Screen → Widget** pattern:

```
modules/<feature>/
├── bindings/      # GetX dependency injection
├── controllers/   # Business logic & state (GetxController)
└── screens/
    ├── widgets/   # Screen-specific sub-widgets
    └── *.dart     # Screen files
```

---

## 🧩 Tech Stack

| Layer | Technology |
|---|---|
| **Framework** | Flutter 3.x (Dart 3.x) |
| **State Management** | [GetX](https://pub.dev/packages/get) `^4.6.6` |
| **Networking** | [Dio](https://pub.dev/packages/dio) `^5.7.0` |
| **Image Caching** | [cached_network_image](https://pub.dev/packages/cached_network_image) `^3.4.1` |
| **Responsive Layout** | [flutter_screenutil](https://pub.dev/packages/flutter_screenutil) `^5.9.3` |
| **SVG Assets** | [flutter_svg](https://pub.dev/packages/flutter_svg) `^2.3.0` |
| **Asset Generation** | [flutter_gen_runner](https://pub.dev/packages/flutter_gen_runner) `^5.10.0` |

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK `>=3.0.0 <4.0.0`
- Dart SDK `>=3.0.0 <4.0.0`
- An Android or iOS device / emulator

### Installation

```bash
# 1. Clone the repository
git clone https://github.com/your-org/mealist_ai.git
cd mealist_ai

# 2. Install dependencies
flutter pub get

# 3. Run code generation (for flutter_gen assets)
dart run build_runner build --delete-conflicting-outputs

# 4. Run the app
flutter run
```

### Running on specific platforms

```bash
# Android
flutter run -d android

# iOS (macOS required)
flutter run -d ios

# With a specific flavor / environment
flutter run --dart-define=ENV=dev
```

---

## 🗂️ Module Breakdown

### 🥦 Pantry Module
The core inventory management system. Users can:
- **Add items** via manual entry or search — with quantity stepper, unit selector, storage location chips (Fridge / Freezer / Pantry), and optional use-by date
- **Search** across all stored ingredients instantly
- **View item details** — edit quantity, storage location, and use-by date; or remove the item via a confirmation sheet
- **Discover recipes** with *What Can I Cook* — AI-matched against current inventory with household safety filtering

### 🧠 Ask Mealist AI
A conversational AI interface where users type natural language questions like _"What can I make with leftover chicken and spinach?"_ and receive rich, context-aware recipe answers.

### 🍳 Cook Mode
Guided step-by-step cooking experience with:
- Ingredient checklist
- Per-step timers
- Swipe navigation between steps
- Completion celebration screen

### 📅 Plan Module
Weekly meal planner letting users assign Breakfast / Lunch / Dinner / Snack slots and track nutritional totals per day.

### 🛒 Shopping Module
Auto-generates a shopping list from missing recipe ingredients. Shopping Mode provides a fullscreen checklist optimised for in-store use.

---

## 🎨 Design System

All design tokens are centralised in `lib/core/constants/`:

| Constant | File | Purpose |
|---|---|---|
| `AppColors` | `app_colors.dart` | Brand palette — bg, primary, accent, text, status, chips, shimmer |
| `AppTextStyles` | `app_text_styles.dart` | Typography scale — display → headline → title → body → label → button |
| `AppSpacing` | `app_spacing.dart` | Spacing, padding, icon sizes, button/input heights |
| `AppRadius` | `app_radius.dart` | Border radius — xs (4) → pill (100) → circle (999) |

### Color Palette

| Token | Hex | Usage |
|---|---|---|
| `bg` | `#F5F3EE` | Warm cream app background |
| `primary` | `#2D5F4F` | Deep forest green — buttons, active states, logo |
| `accent` | `#E8A838` | Golden orange — AI indicators, highlights |
| `textPrimary` | `#1A1A1A` | Main content text |
| `error` | `#D94040` | Destructive actions, expiry warnings |

---

## 📐 Shared Widgets

Reusable components in `lib/shared/common_widgets/`:

| Widget | Description |
|---|---|
| `PrimaryButtonWidget` | Full-width green CTA button with loading state |
| `OutlineButtonWidget` | Bordered secondary button |
| `AppTextFieldWidget` | Styled form field with label, hint, prefix/suffix icons |
| `SelectionChipWidget` | Animated chip for multi-select (onboarding, filters) |
| `EmptyStateWidget` | Illustrated empty-state placeholder |
| `ErrorStateWidget` | Error state with retry action |
| `LoadingStateWidget` | Shimmer/spinner loading placeholder |

---

## 🔐 Routing

All routes are defined in `lib/routes/app_routes.dart` as string constants and registered in `lib/routes/app_pages.dart` with their GetX bindings and transitions.

```dart
// Example navigation
Get.toNamed(AppRoutes.addToPantry);
Get.toNamed(AppRoutes.recipeDetails, arguments: { 'name': 'Greek Lemon Chicken' });
Get.back();
```

Key route groups:

```
/               → SplashScreen
/welcome        → WelcomeScreen
/main           → MainShellScreen (bottom nav)
/pantry         → MyPantryScreen
/pantry/add     → AddToPantryScreen
/pantry/search  → SearchPantryScreen
/pantry/item-details  → ItemDetailsScreen
/pantry/what-can-i-cook → WhatCanICookScreen
/recipes/details → RecipeDetailsScreen
/cook-mode      → CookModeScreen
/ask-mealist    → AskMealistScreen
/shopping-list  → ShoppingListScreen
```

---

## 🤝 Contributing

1. **Fork** the repository
2. Create your feature branch: `git checkout -b feature/your-feature-name`
3. Commit your changes: `git commit -m 'feat: add amazing feature'`
4. Push to the branch: `git push origin feature/your-feature-name`
5. Open a **Pull Request**

### Code Style

- Follow the existing **feature-first module structure**
- Use `AppColors`, `AppTextStyles`, `AppSpacing` — never hardcode values
- All responsive sizing must use `.w` / `.h` from `flutter_screenutil` (font sizes excluded)
- Prefix private widget classes with `_`
- Every public widget must have a `const` constructor with a `super.key` parameter
- Run `flutter analyze` before submitting — zero errors required

---

## 📄 License

```
MIT License

Copyright (c) 2024 Mealist.ai

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
```

---

<p align="center">
  Built with ❤️ using Flutter &nbsp;|&nbsp; Powered by AI &nbsp;|&nbsp; Designed for real kitchens
</p>
