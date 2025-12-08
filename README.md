# 📝 Task Planner App
A simple **Flutter** project demonstrating **Clean Architecture**, **Offline-First approach**, and **BLoC state management**, with **Supabase** for backend + authentication.

---

## 🚀 Features
- Add tasks for a selected date
- Edit/Delete tasks
- Fully offline-first (local DB sync)
- Clean and scalable architecture
- Authentication (email/password)
- Cross-platform (Android/iOS/Web)

---

## 🏛️ Architecture
This project follows **Clean Architecture**, separating the codebase into clear layers:

## 🗄️ Backend – Supabase
![Supabase Logo](https://raw.githubusercontent.com/supabase/supabase/master/web/static/supabase-logo.svg)

Used for:
- Authentication (Email/Password)
- Cloud database
- Sync with local storage (offline-first)

---

## 🔐 Authentication
Handled completely using **Supabase Auth**.

Key features:
- Email/Password login
- Session handling
- Getting current logged-in user
- Auto-refresh tokens

---

## 🧠 State Management – BLoC
![Bloc Logo](https://raw.githubusercontent.com/felangel/bloc/master/docs/assets/bloc_logo_full.png)

Why BLoC?
- Predictable state flow
- Great testability
- Clean separation of logic from UI

---

## 💾 Offline First
The app stores all tasks locally and syncs with backend when online.

Local storage uses:
- **Hive

---

## 🧱 Tech Stack
| Tech | Purpose |
|------|---------|
| ![Flutter](https://upload.wikimedia.org/wikipedia/commons/4/44/Google-flutter-logo.svg) | UI Framework |
| ![Dart](https://upload.wikimedia.org/wikipedia/commons/f/fe/Dart_programming_language_logo.svg) | Language |
| ![Supabase](https://raw.githubusercontent.com/supabase/supabase/master/web/static/supabase-logo.svg) | Backend + Auth |
| ![Bloc](https://raw.githubusercontent.com/felangel/bloc/master/docs/assets/bloc_logo_full.png) | State Management |
| 🗄️ Local DB | Offline-first storage |
