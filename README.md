# CoinPeek 
![Architecture Diagram](assets/logo.svg)
> ### **CoinPeek** is a real-time crypto widget app for **macOS** and **iOS**, delivering live prices and market insights from multiple providers in a sleek, customizable interface.

---

## 🚀 CoinPeek – Crypto Widget Swift

![Swift](https://img.shields.io/badge/swift-F54A2A?style=for-the-badge\&logo=swift\&logoColor=white) ![macOS](https://img.shields.io/badge/mac%20os-000000?style=for-the-badge\&logo=macos\&logoColor=F0F0F0)

> A modular, scalable, real-time cryptocurrency widget app built with **Swift**, **SwiftUI**, and **Socket.IO**, designed for the macOS ecosystem.
>
> CoinPeek allows users to select, configure, and display dynamic crypto widgets on their desktop or navbar — powered by multiple data providers.

---

## 🧩 Architecture Overview

> The app follows a clean, layered architecture inspired by **MVVM**, **Clean Architecture**, and **modular event-driven** patterns. It is designed to be testable, extensible, and highly reusable.
![Architecture Diagram](assets/architecture.png)
---

## 🔷 Architecture Layers

### 🎨 **1. UI Layer**

> Responsible for all user interactions and SwiftUI rendering.

* `WidgetSelector`: Choose and configure desktop widgets
* `NavbarWidget`: Minimal view pinned to macOS menu bar
* `SwiftUI Views`: Reactive views bound to ViewModels

### 🔁 **2. Transformer Layer**

> Prepares raw crypto data for UI rendering.

* `Normalizer`: Converts API-specific formats into common models
* `Formatter`: Formats price, volume, date, etc.
* `UnitConverter`: Handles currency and unit conversion

### 🔄 **3. Interaction Layer**

> Orchestrates core app behavior in response to events.

* `WidgetCoordinator`: Links configured widgets to services and data
* `SocketEventHandler`: Routes socket events to handlers
* `ProviderRouter`: Dynamically selects the appropriate crypto provider
* `TaskScheduler`: Manages periodic sync and background jobs

### ⚙️ **4. Config Layer**

> Holds static or environment-based configuration.

* `AppConfig`: Loads `.plist`, `.env`, or secure configs (API URLs, themes, feature flags)

### 🔧 **5. Settings Layer**

> Manages user-specific and runtime settings.

* `UserPreferences`: Currency, refresh rate, selected provider
* `WidgetConfigurations`: Per-widget state and layout
* `Networking`: Preferences like proxy or Wi-Fi-only
* `Persistence`: Saves and loads settings using `UserDefaults`, files, or secure storage

### 🏗 **6. Infrastructure Layer**

> Handles all external I/O and system interaction.

* `CryptoProviderClient`: REST and WebSocket APIs for price data
* `Socket.IO Client`: Real-time data stream using `socket.io-client-swift`
* `Network Layer`: `URLSession` abstraction
* `Persistence`: `FileManager`, `SQLite`, `CoreData`

### 🧠 **7. Domain Layer**

> Defines business logic, data models, and protocols.

* `Entities / Models`: `CryptoAsset`, `PricePoint`, etc.
* `Enums & Constants`: Currency types, provider keys, update intervals
* `Protocols`: `CryptoProviderProtocol`, `WidgetRenderable`, etc.

> ✅ This layer is **independent** and **fully reusable** across platforms.

---

## 🔁 Data Flow Summary

```
[External Providers → Infrastructure Layer]
        ↓
[Services + Config/Settings]
        ↓
[Interaction Layer → Transformer Layer]
        ↓
[UI Layer (Widgets)]
```

---

## ✅ Key Design Principles

| Principle                 | Implementation                                                   |
| ------------------------- | ---------------------------------------------------------------- |
| **Modular**               | Each layer is replaceable, testable, and injectable              |
| **Reactive/Event-Driven** | Socket.IO + Combine / async/await                                |
| **MVVM + Clean Arch**     | Clear separation of state, view, logic, side effects             |
| **Multi-provider ready**  | `ProviderRouter` + Strategy Pattern                              |
| **Easy Extensibility**    | Add new widgets, services, or providers via protocol conformance |

---

## 🚀 Getting Started

```bash
git clone https://github.com/amirtaherkhani/coinpeek.git
cd coinpeek
open CoinPeek.xcodeproj
```

> Swift Package Manager will auto-resolve all dependencies (e.g. `socket.io-client-swift`).

---

## 📁 Folder Structure

```
CoinPeek/
├── UI/
├── Transformers/
├── Interaction/
├── Services/
├── Settings/
├── Config/
├── Infrastructure/
├── Domain/
```

---

## 🧪 Testing

* Unit tests for Domain and Services
* Snapshot tests for SwiftUI widgets
* Integration tests for data pipelines and socket events

---

## 📚 Technologies Used

| Purpose            | Tools                                  |
| ------------------ | -------------------------------------- |
| **UI**             | SwiftUI                                |
| **State/Events**   | Combine / async/await                  |
| **Real-Time Data** | Socket.IO via `socket.io-client-swift` |
| **Storage**        | UserDefaults, FileManager, SQLite      |
| **Network**        | URLSession                             |

---

## 📄 License

**MIT © 2025 Amir Taherkhani**

---

## 🤝 Contributing

Feel free to open issues or submit PRs if you’d like to extend functionality, fix bugs, or contribute crypto provider integrations.

---

**CoinPeek – Real-time market insights at a glance.**
