# **Infrastructure Layer**

#### The Infrastructure layer handles all external input/output, system interaction, and provider integration. It provides concrete implementations of protocols defined in the Domain layer (e.g. CryptoProviderProtocol, RepositoryProtocol).

#### This is where networking, sockets, persistence, DTOs, and provider-specific adapters live.

---

## 📂 Structure
```
Infrastructure/
├── Networking/
│   ├── Endpoint.swift
│   ├── RequestBuilder.swift
│   ├── NetworkClient.swift
│   └── HTTPError.swift
├── Sockets/
│   ├── SocketClient.swift
│   └── SocketEvent.swift
├── Providers/
│   ├── ProviderFactory.swift
│   └── {Provider}/
│       ├── {Provider}Provider.swift
│       ├── Networking/
│       │   ├── {Provider}Endpoint.swift
│       │   └── {Provider}RequestBuilder.swift
│       ├── DTO/
│       │   ├── {Provider}MarketsDTO.swift
│       │   ├── {Provider}TickerDTO.swift
│       │   └── {Provider}StreamEventDTO.swift
│       ├── Mappers/
│       │   └── {Provider}DTOMapper.swift
│       └── Mock/
│           └── Mock{Provider}Provider.swift
├── DTO/
│   ├── Common/
│   │   ├── CryptoAssetDTO.swift
│   │   ├── MarketPairDTO.swift
│   │   ├── PricePointDTO.swift
│   │   └── ErrorDTO.swift
│   └── Persistence/
│       ├── UserSettingsDTO.swift
│       └── WidgetConfigDTO.swift
├── Mappers/
│   ├── DTOToDomainMappers.swift
│   └── ProviderMappers.swift
└── Persistence/
    ├── KeyValueStore.swift
    ├── UserDefaultsStore.swift
    ├── FileStore.swift
    └── SQLiteRepository.swift
```



## 🧱 Responsibilities by Directory

**Networking**
    -Endpoint.swift → Encapsulates API paths and query parameters.
    -RequestBuilder.swift → Builds URLRequest objects from endpoints.
    -NetworkClient.swift → Executes HTTP calls with URLSession and decodes responses.
    -HTTPError.swift → Defines HTTP/network-related errors.

**Sockets**
    -    SocketClient.swift → Abstraction for real-time socket connections (e.g. Socket.IO or WebSocket).
    -    SocketEvent.swift → Enum of supported socket events.

**Providers**
    -    Each provider lives in its own folder ({Provider}/).
    -    {Provider}Provider.swift → Concrete implementation of CryptoProviderProtocol.
    -    Networking/ → Provider-specific endpoints and request builders.
    -    DTO/ → Data Transfer Objects representing raw API payloads.
    -    Mappers/ → Transforms provider DTOs into Domain entities.
    -    Mock/ → Fake provider used for unit tests and SwiftUI previews.
    -    ProviderFactory.swift → Centralized factory to construct providers.

**DTO**
    -    Common/ → DTOs reused across providers (e.g. CryptoAssetDTO, MarketPairDTO).
    -    Persistence/ → DTOs for saving/loading user settings and widget configurations.

**Mappers**
    -    DTOToDomainMappers.swift → Generic DTO → Domain conversion logic.
    -    ProviderMappers.swift → Delegates provider-specific mappings.

Persistence/
    -    KeyValueStore.swift → Abstract interface for key-value storage.
    -    UserDefaultsStore.swift → Concrete implementation backed by UserDefaults.
    -    FileStore.swift → Simple file read/write abstraction.
    -    SQLiteRepository.swift → Placeholder for a future SQLite-backed repository.

⸻

## 🌍 Providers 

> Purpose: Providers implement the Domain contract (CryptoProviderProtocol) to fetch/stream market data from external services. Each provider is isolated so you can add/replace sources without touching Domain/UI.

### 📂 Folder Layout (template)
```
Infrastructure/Providers/
└── {Provider}/
    ├── {Provider}Provider.swift
    ├── Networking/
    │   ├── {Provider}Endpoint.swift
    │   └── {Provider}RequestBuilder.swift
    ├── DTO/
    │   ├── {Provider}MarketsDTO.swift
    │   ├── {Provider}TickerDTO.swift
    │   └── {Provider}StreamEventDTO.swift
    ├── Mappers/
    │   └── {Provider}DTOMapper.swift
    └── Mock/
        └── Mock{Provider}Provider.swift
```
## 🔌 Responsibilities
    •    Implement CryptoProviderProtocol (connect/disconnect, list markets, latest price, streams).
    •    Map DTOs → Domain (never return DTOs upstream).
    •    Handle provider-specific auth, rate limits, retries.
    •    Normalize symbols and pairs before mapping to Domain.

## 🔁 Lifecycle
    1.    connect(): Initialize HTTP/sockets/auth.
    2.    listMarketPairs(): Fetch and normalize tradable pairs.
    3.    getLatestPrice(for:): Snapshot call for a symbol/pair.
    4.    streamPrices(for:onUpdate:): Subscribe/unsubscribe to live updates.
    5.    disconnect(): Tear down resources safely.

## 🧩 DTOs & Mappers
    •    DTOs mirror external JSON schemas exactly.
    •    Validation is performed in Domain ValueObjects during mapping.
    •    Mappers are pure functions: deterministic, no I/O.

## 🌐 Networking
    •    {Provider}Endpoint.swift → Encapsulates API paths.
    •    {Provider}RequestBuilder.swift → Adds headers, signing, etc.
    •    All requests executed via shared NetworkClient.

## 🚨 Error Handling
    •    Transport errors → HTTPError.
    •    Provider/domain-specific issues → mapped to DomainError.
    •    No raw error strings leak outside Infrastructure.

## 🧪 Testing & Mocks
    •    Mock{Provider}Provider.swift → Stubbed provider for tests and previews.
    •    Unit tests for DTO parsing and mapper conversions.
    •    Socket tests simulate event sequences.

## 🏷️ Naming Conventions
    •    Provider root: {Provider}Provider.swift
    •    DTOs: {Provider}{Thing}DTO.swift
    •    Mapper: {Provider}DTOMapper.swift
    •    Networking: {Provider}Endpoint.swift, {Provider}RequestBuilder.swift
    •    Mock: Mock{Provider}Provider.swift

## ➕ Adding a New Provider
    •    Create directory structure (Networking, DTO, Mappers, Mock).
    •    Define endpoints and DTOs.
    •    Implement DTO → Domain mappers.
    •    Implement {Provider}Provider conforming to CryptoProviderProtocol.
    •    Add a mock provider.
    •    Register provider in ProviderFactory.swift.
    •    Write tests for DTO decoding, mappers, and provider behavior.

---

## 🧭 Principles
    1.    Implements Domain protocols → Domain defines what, Infrastructure defines how.
    2.    External I/O only → Networking, sockets, persistence live here.
    3.    DTOs vs Entities → DTOs mirror external schemas; Entities are validated.
    4.    Mappers at boundaries → Always convert DTOs → Entities.
    5.    Replaceable providers → Each provider is self-contained and swappable.
    6.    Mocks for testing → Every provider should have a Mock implementation.


