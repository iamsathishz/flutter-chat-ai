# 💬 Flutter AI Chat App

A modern, real-time AI chatbot built with **Flutter**, using OpenRouter’s LLaMA 3 model for streaming AI responses. This app features beautiful UI, light/dark theme support, and a clean, maintainable architecture with controllers, services, and widgets.

![Purple Pink Gradient Mobile Application Presentation](https://github.com/user-attachments/assets/7938bcad-7326-4446-afd9-ef374d154fda)

---

## 🚀 Features

- 💬 Real-time AI chat using OpenRouter API
- ⚡ Server-Sent Events (SSE) streaming
- 🎨 Light & dark theme switching
- 🧱 Modular folder structure (clean architecture)
- 📦 State management using controllers
- 🧠 Meta LLaMA 3 (8B Instruct) model integration
- 💾 Local storage using `Hive`
- 🔄 Graceful request cancellation
- ✅ Works on Android, iOS, and Web
- 🛠️ CI/CD for Android via GitHub Actions

---

## 📡 AI Backend – OpenRouter API

This app uses [OpenRouter](https://openrouter.ai) to access powerful open-source AI models via their `/chat/completions` endpoint with streaming.

- **Model**: `meta-llama/llama-3-8b-instruct:nitro`
- **Transport**: `Server-Sent Events (SSE)`
- **Method**: `POST` request
- **Streaming**: Real-time word-by-word output
- **Authorization**: Bearer Token from `.env`

```
POST https://openrouter.ai/api/v1/chat/completions
Authorization: Bearer <YOUR_API_KEY>
Content-Type: application/json
Accept: text/event-stream
```

## 📁 Project Structure

| Folder/File              | Purpose                                           |
|--------------------------|---------------------------------------------------|
| `lib/`                   | Main source directory                             |
| ├── `controllers/`       | Contains state management and business logic      |
| │   ├── `chat_controller.dart`    | Manages chat-related logic         |
| │   └── `theme_controller.dart`   | Handles theme switching logic      |
| ├── `models/`            | Data classes and serialization                    |
| │   ├── `message.dart`            | Message model class                |
| │   └── `message.g.dart`          | Generated model code               |
| ├── `services/`          | API and local storage services                    |
| │   ├── `api_service.dart`        | Handles API calls for streaming AI chat responses |
| │   └── `storage_service.dart`    | Manages local data storage         |
| ├── `views/`             | UI structure                                     |
| │   ├── `screens/`       | Screens or pages of the app                       |
| │   │   ├── `app_drawer.dart`     | App drawer UI                      |
| │   │   └── `chat_screen.dart`    | Main chat screen                   |
| │   └── `widgets/`       | Reusable UI components                           |
| │       ├── `chat_bubble.dart`    | Message display bubble             |
| │       ├── `quick_quize.dart`    | Quiz UI widget                     |
| │       └── `typing_indicator.dart`| Typing indicator animation        |
| ├── `env.dart`           | Environment/configuration values                |
| ├── `locator.dart`       | Service locator (e.g., GetIt setup)              |
| └── `main.dart`          | App entry point                                  |

---

## 🧠 Tech Stack

| Layer       | Technology         |
|-------------|--------------------|
| Framework   | Flutter (Dart)     |
| State Mgmt  | Provider|
| Backend     | OpenRouter API |
| Storage     | Hive |
| CI/CD	     | GitHub Actions |

---

## 🔄 GitHub Actions CI/CD
### 📱 Android – CI Pipeline
GitHub Actions automatically builds .apk and .aab files on push/pull requests to development branch.

✅ Supported Tasks:
✅ Flutter installation

✅ Dependency caching

✅ APK + AAB release builds

✅ Artifact upload with version tag

## 🍎 iOS Build Note
### To build .ipa (iOS):

You must use a macOS system (mac or cloud runner)

Use Codemagic, Bitrise, or manual Xcode build on a Mac with Apple Developer account.

GitHub Actions cannot build iOS apps without a macOS runner.

---

## 🛠️ Getting Started

### 📦 Prerequisites

- Flutter SDK (3.29.3)
- Dart 3.x
- Android Studio or VS Code
- OpenRouter API Key

### 🚀 Installation

```bash
git clone https://github.com/iamsathishz/flutter-chat-ai.git
cd flutter-chat-ai
flutter pub get
flutter run
```
---

## 🔐 Environment Setup

Before running the app, open `lib/env.dart` and add your OpenRouter API key:

```dart
class Env {
  static const String openrouterKey = 'your-api-key-here';
}
```

You can get a free API key from [https://openrouter.ai](https://openrouter.ai)

---

## 📄 License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

## 👨‍💻 Author

**Sathishkumar Raman**  
- GitHub: [@iamsathishz](https://github.com/iamsathishz)
- LinkedIn: [https://www.linkedin.com/in/sathishkumarraman2/](https://www.linkedin.com/in/sathishkumarraman2/)
- Mail: Sathishkumarraman888@gmail.com
  

