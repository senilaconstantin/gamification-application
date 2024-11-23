# Gamification Application

The **Gamification Application** is an interactive platform designed to encourage users to participate in challenges (quests), earn rewards, and track their progress using a 
system of **tokens**, **badges**, and **ranking**. This project combines modern gamification concepts with a robust backend and a sleek, user-friendly iOS application.

[Watch the app's introduction video on YouTube](https://youtu.be/iXLwqTdJVKk)

## 🎯 Key Features

1. **Quest Management**
   - Users can create quests if they have sufficient tokens, badges, or ranking to reward participants.
   - Other users can join and solve quests to earn rewards.

2. **Reward System**
   - Successfully completing quests rewards users with tokens, badges, and ranking points.
   - Progress and achievements are displayed on the user’s profile to track their performance.

3. **Competitive Environment**
   - A ranking system motivates users to participate actively and strive for higher achievements.
   - Tokens and badges encourage friendly competition and engagement.

## 🛠️ Technologies Used

### Backend
- **Language:** Java  
- **Framework:** Spring Boot  
- **Database:** PostgreSQL  
- **Key Functionalities:**
  - User authentication and authorization using secure protocols.
  - Quest creation and management with reward distribution logic.
  - RESTful API for seamless communication with the iOS application.

### Frontend (iOS)
- **Language:** Swift  
- **Framework:** SwiftUI  
- **Key Functionalities:**
  - A modern, intuitive interface that allows users to browse, create, and participate in quests.
  - Real-time updates for user progress, including tokens, badges, and ranking.
  - Smooth integration with backend APIs for a seamless experience.

## 🔨 How It Works

1. **User Registration and Profile Creation**  
   - Users can create an account, set up their profile, and start participating in quests.

2. **Quest Creation**  
   - Users with enough tokens, badges, or ranking points can propose new quests to challenge others.

3. **Quest Participation and Rewards**  
   - Users join quests and complete them to earn tokens, badges, and ranking points.  
   - Rankings are dynamically updated based on completed quests and rewards.

4. **Tracking Progress**  
   - A personalized dashboard allows users to monitor their tokens, badges, and ranking in real time.

## 🚀 Development Process

This project was developed with a focus on modularity and scalability, utilizing modern tools and best practices:

- **Backend Development:**  
  Built with Java and Spring Boot, the backend manages user data, authentication, quest logic, and reward distribution.
  PostgreSQL was used to handle persistent storage for users, quests, and rewards. The backend exposes RESTful APIs for communication with the mobile app.

- **Frontend Development (iOS):**  
  The iOS application was developed using Swift and SwiftUI to provide a clean, responsive, and user-friendly interface.
  Key features like quest management, user ranking display, and real-time updates were implemented to deliver a polished experience.

- **Integration:**  
  The backend and frontend communicate through secure APIs, ensuring smooth and efficient data exchange.

## 🏗️ Project Structure

- **Backend:** Contains all server-side logic, API endpoints, and database management.  
- **Frontend:** The iOS SwiftUI app providing the user interface and interaction logic.  
