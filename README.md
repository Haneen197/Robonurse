# Robonurse

Robonurse is a modern Flutter healthcare management app designed for both patients and doctors. It provides medication tracking, patient management, and real-time progress visualization in a secure, user-friendly interface.

## Features
- **Role-based access:** Separate dashboards for patients and doctors
- **Patient Dashboard:**
  - Personal info card
  - Medication checklist (with frequency support)
  - Pie chart for medication progress
  - Drawer with robot battery level, info, help, and logout
- **Doctor Dashboard:**
  - View all patients
  - Assign medications with frequency and dose
  - Add new medications
  - Logout and help drawer
- **Authentication:** Secure signup and login with Firebase
- **Firestore Integration:** Real-time updates and secure data storage
- **Responsive UI:** Clean, modern design for all devices

## Screenshots

Add your screenshots to `assets/screenshots/` and they will appear here:

![Login Screen](assets/screenshots/login.png)
![Patient Dashboard](assets/screenshots/patient_dashboard.png)
![Doctor Dashboard](assets/screenshots/doctor_dashboard.png)

## Getting Started

### Prerequisites
- [Flutter](https://flutter.dev/docs/get-started/install) (stable channel)
- [Firebase CLI](https://firebase.google.com/docs/cli) (for backend setup)
- A configured Firebase project (see below)

### Installation
1. **Clone the repository:**
   ```sh
   git clone https://github.com/Haneen197/Robonurse.git
   cd Robonurse
   ```
2. **Install dependencies:**
   ```sh
   flutter pub get
   ```
3. **Configure Firebase:**
   - Add your `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) to the respective folders.
   - Update Firestore rules as needed.
4. **Run the app:**
   ```sh
   flutter run
   ```

## Usage
- **Patients:** Sign up, log in, view and check off medications, track progress, and view battery level.
- **Doctors:** Log in, view patients, assign medications, and manage patient data.

## Contributing
Contributions are welcome! To contribute:
1. Fork the repository
2. Create a new branch (`git checkout -b feature/your-feature`)
3. Commit your changes (`git commit -am 'Add new feature'`)
4. Push to the branch (`git push origin feature/your-feature`)
5. Open a pull request

## License
This project is licensed under the MIT License.

---

For questions or support, open an issue or contact the maintainer.
