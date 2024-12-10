# UASD Mobile Application

## General Description
The UASD Mobile Application is designed to help students of the Universidad Autónoma de Santo Domingo (UASD) access relevant information and academic management tools, facilitating interaction with the university. The app features an intuitive interface to improve student interaction with the university while ensuring the security of personal data.

## Features

### 1. **Landing Screen**
**Description**: Upon opening the app, the landing screen will display information about UASD, such as its mission, vision, and values, along with representative images and video.  
- Provides a button to log in to the application.

### 2. **Login**
**Description**: Allow students to log in with their username and password.  
**Options**:
- **Password Recovery**: Students can follow a process to recover their password.
- **Enrollment**: A link “Study with Us” redirects to the university’s enrollment page.  

### 3. **Main Menu**
Once logged in, students will see the following options:

- **News**: Displays the latest university news, updated from a news API or RSS feed.
- **Schedule (My Subjects)**: Shows students' class schedules. Clicking on a subject will show the classroom's location on a map.
- **Preselection**: Allows students to preselect subjects for the next academic term. Preselections can only be modified by authorized personnel on the backend.
- **Debt**: Shows the student's outstanding debt with the university, with a link to a payment page.
- **Requests**: Lets students make and track administrative requests.
- **My Tasks**: Displays a list of pending tasks with links to the virtual classroom (e.g., Moodle).
- **Events**: Lists university events and allows students to view event details.
- **Videos**: Displays a list of videos related to the university and educational content.
- **About**: Shows developer information, including a photo, name, and registration number.
- **Logout**: Allows the student to log out of the application.

## API Integration
The application integrates with the [UASD API](https://uasdapi.ia3x.com/swagger/index.html) for accessing data related to news, events, class schedules, and more.

## Design
The app is designed with a user-friendly and modern interface that reflects UASD's branding. It focuses on ease of use and intuitive navigation while ensuring a secure environment for user data.

## Technologies
- **Flutter**: For building the mobile application.
- **Secure Storage Plugin**: For securely storing user credentials and other sensitive data on the device.
- **API**: UASD's external API for accessing university data.

## Getting Started
To get started with the project, clone the repository and follow the setup instructions below:

### Prerequisites
- Flutter SDK
- Android Studio or Visual Studio Code

### Setup
1. Clone the repository:
   ```bash
   git clone https://github.com/rachelyperezdev/uasd_app.git

2. **Navigate to the project directory**:
   ```bash
   cd uasd_app

3. **Install dependencies**:
   ```bash
   flutter pub get

4. **Run the app**:
   ```bash
   flutter run
