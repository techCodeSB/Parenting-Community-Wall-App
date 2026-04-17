# 📱 Flutter Project Setup Guide

##  Project Overview
This project is a Flutter-based frontend application that connects with a backend API to provide features like post creation, feed display, likes, and comments.

---

##  Getting Started

### 1. Prerequisites
Make sure you have the following installed:

- Flutter SDK (latest stable version)
- Dart SDK
- Android Studio / VS Code
- Android Emulator or Physical Device
- Git

Verify Flutter installation:
```bash
flutter --version
```

---

### 2. Clone the Repository
```bash
git clone https://github.com/techCodeSB/Parenting-Community-Wall-App.git
cd Parenting-Community-Wall-App
```

---

### 3. Install Dependencies
```bash
flutter pub get
```

---

### 4. Configure Environment

Update your API base URL inside the project:

```dart
class Constant {
  static const String apiUrl = "http://YOUR_BACKEND_URL";
}
```

#### Example:
- Local: `http://10.0.2.2:3000` (Android Emulator)
- Live: Your deployed backend URL

---

### 5. Run the Application
```bash
flutter run
```

---

## 📂 Project Structure

```
lib/
│
├── models/          # Data models (Post, User, etc.)
├── controllers/     # Business logic & API calls
├── screens/         # UI screens (Feed, Login, etc.)
├── widgets/         # Reusable UI components
├── services/        # API services
├── utils/           # Constants, helpers
└── main.dart        # Entry point
```

---

##  API Integration

Example API call:
```dart
final res = await http.get(
  Uri.parse("${Constant.apiUrl}/posts?page=1&limit=10"),
);
```

---

##  Features

- 📝 Create Post  
- ❤️ Like / Unlike Post  
- 💬 Add Comments  
- 📜 Infinite Scroll Feed  
- 🔄 API Integration  

---

## ⚙️ State Management

- Uses `Provider` for state management  
- API calls handled inside controllers  
- UI updates using `notifyListeners()`  

---

## 🧪 Testing

Run tests:
```bash
flutter test
```

---

## 🐛 Common Issues & Fixes

### ❌ API not working on emulator
✔ Use:
```
http://10.0.2.2:PORT
```

### ❌ Dependencies error
✔ Run:
```bash
flutter clean
flutter pub get
```

---

## 📦 Build APK

```bash
flutter build apk --release
```
