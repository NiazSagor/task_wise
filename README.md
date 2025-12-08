### 📝 TaskWise
A simple **Flutter** project demonstrating **Clean Architecture**, **Offline-First approach**, and **BLoC state management**, with **Supabase** for backend + authentication.

---

#### 🚀 Features
- Add tasks for a selected date
- Edit/Delete tasks
- Fully offline-first (local DB sync)
- Clean and scalable architecture
- Authentication (email/password)
- Cross-platform (Android/iOS/Web)

---

####  🏛️ Architecture
This project follows **Clean Architecture**, separating the codebase into clear layers:

    lib/
     ├─ core/
     │   ├─ error/
     │   ├─ usecase/
     │   └─ utils/
     │
     ├─ features/
     │   └─ tasks/
     │       ├─ data/
     │       │   ├─ datasources/
     │       │   ├─ models/
     │       │   └─ repositories/
     │       ├─ domain/
     │       │   ├─ entities/
     │       │   ├─ repositories/
     │       │   └─ usecases/
     │       └─ presentation/
     │           ├─ bloc/
     │           ├─ pages/
     │           └─ widgets/
     │
     ├─ services/
     │   └─ supabase_service.dart
     │
     └─ main.dart

---

#### 🧱 Tech Stack
<table style="margin-top:0; padding-top:0;">
   <tr>
      <th>Technology</th>
      <th>Description</th>
   </tr>
   <tr>
      <td style="display:flex; align-items:center; gap:10px;">
         <img src="https://logo.svgcdn.com/devicon/flutter-original.png" width="30">
         <span><b>Flutter</b></span>
      </td>
      <td>A cross-platform UI framework used to build the app.</td>
   </tr>
   <tr>
      <td style="display:flex; align-items:center; gap:10px;">
         <img src="https://logo.svgcdn.com/devicon/supabase-original.png" width="40">
         <span><b>Supabase</b></span>
      </td>
      <td>Backend service providing database, authentication, and API.</td>
   </tr>
   <tr>
      <td style="display:flex; align-items:center; gap:10px;">
         <img src="https://bloclibrary.dev/_astro/bloc.DJLDGT9c_Z2azGxg.svg" width="50">
         <span><b>Bloc</b></span>
      </td>
      <td>State management solution used for handling business logic.</td>
   </tr>
   <tr>
      <td style="display:flex; align-items:center; gap:10px;">
         <img src="https://logo.svgcdn.com/devicon/postgresql-original.png" width="40">
         <span><b>PostgreSQL</b></span>
      </td>
      <td>Database is a relational database</td>
   </tr>
      <tr>
      <td style="display:flex; align-items:center; gap:10px;">
         <img src="https://raw.githubusercontent.com/hivedb/hive/master/.github/hive.svg" width="40">
         <span><b>Hive</b></span>
      </td>
      <td>Local storage and caching</td>
   </tr>
</table>

---

#### 📷 Screenshots
<p align="center">
    <img src="./ss/image4.jpeg" alt="Screenshot 1" width="200"/>
    <img src="ss/image5.jpeg" alt="Screenshot 1" width="200"/>
</p>

The mockups are made from https://previewed.app/

