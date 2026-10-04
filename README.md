# MedEASE

> Smarter care, made easy.

MedEASE is a cross-platform Flutter health companion that brings together everyday healthcare tasks in one place: appointments, personal health records, blood-donation information, and an initial AI-guided consultation experience.

## From idea to presentation

### The idea

The project started from a simple problem: important healthcare tasks are often fragmented. Booking an appointment, finding blood-donation information, and keeping health documents can require separate services, manual processes, or scattered paper and digital records.

### The goal

MedEASE was designed as a single, accessible platform to:

- centralize appointments, health records, and blood-donation services;
- provide a consistent experience across Android, iOS, web, and desktop platforms;
- protect user access through authentication; and
- make essential healthcare information easier to reach.

### The implementation

The application is built with Flutter and Firebase. Development followed an iterative approach, with individual features developed and refined as parts of one unified health platform.

### The presentation

The complete project presentation—including the problem background, goals, methodology, feature overview, and demonstration—is available here:

**[Open the MedEASE presentation](docs/presentation-file.pdf)**

## Features

- **Secure authentication** — email sign-up/sign-in and Google sign-in flows using Firebase Authentication.
- **Blood-donation management** — donor registration, donation-center discovery, eligibility information, and campaign details.
- **Doctor appointments** — browse doctors, view appointment details, and schedule upcoming visits.
- **Centralized health records** — a place to upload and organize health documents such as prescriptions and test results.
- **AI consultation** — a conversational interface for general symptom and wellness information.

> MedEASE's consultation feature provides general information only. It is not a replacement for professional diagnosis, treatment, or emergency medical care.

## Technology

- **Frontend:** Flutter and Dart
- **Authentication & backend services:** Firebase Authentication and Cloud Firestore
- **Platforms:** Android, iOS, web, macOS, Windows, and Linux

## Getting started

1. Install the [Flutter SDK](https://docs.flutter.dev/get-started/install).
2. Clone the repository and open the project directory.
3. Install dependencies:

   ```bash
   flutter pub get
   ```

4. Configure Firebase for your target platform if required.
5. Run the app:

   ```bash
   flutter run
   ```

## Project team

- Ariful Islam Mohsin
- Liana Shams
- Rashedul Islam
