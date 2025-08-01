# Domain Layer

The **Domain** layer contains the core business rules for CoinPeek. It is **framework-agnostic**, **immutable by default**, and **independent** of UI, persistence, and networking. Everything here should remain reusable across macOS/iOS, CLIs, or other apps.

---




## 🧱 What goes where

### Entities
**Purpose:** Business objects that have an **identity** and domain behavior.
**Files:**
- **CryptoAssetEntity.swift** – Core asset (id/symbol/name).
- **MarketPairEntity.swift** – Base/quote pair (e.g., BTC/USDT) using validated symbols.
- **PricePointEntity.swift** – Price at a timestamp + optional OHLC fields.
- **WidgetConfigEntity.swift** – Widget domain config (pair, refresh interval, style tokens).
- **UserSettingsEntity.swift** – Domain-facing preferences (currency, theme, provider key).

> Entities may *compose ValueObjects*; keep them small and immutable.

### Enums
**Purpose:** Closed sets of domain concepts.
**Files:**
- **CurrencyTypeEnum.swift** – Supported fiat/crypto currency codes (domain-level).
- **ProviderKeyEnum.swift** – Known provider identifiers (e.g., binance, coinbase, mock).
- **UpdateIntervalEnum.swift** – Canonical refresh intervals (e.g., s5, s30, m1).

### Protocols
**Purpose:** Abstract contracts that **decouple Domain** from Infrastructure/UI.
- **CryptoProviderProtocol.swift** – Market data interface (list pairs, latest price, streams).
- **WidgetRenderableProtocol.swift** – Domain-facing widget model contract (snapshot + observe).
- **RepositoryProtocol.swift** – Generic persistence contract for domain entities.

### Errors
- **DomainError.swift** – Domain-specific failures (invalid value, unsupported currency, etc.).
  Map these to user-facing messages in higher layers.

### ValueObjects
**Purpose:** Small, immutable, identity-less types with built-in validation & helpers.
- **MoneyValue.swift** – Amount + currency; safe compare within same currency.
- **PercentageValue.swift** – Percentage change with convenience predicates.
- **TickerSymbolValue.swift** – Uppercased symbol (A–Z, length-limited).
- **TimestampValue.swift** – Validated Unix seconds, comparable + `Date` accessor.

### Validation
- **Validator.swift** – Tiny combinator to build simple runtime checks (Zod-like without a dependency).
  Use only if it improves clarity—most validation should live in VO initializers.

---

## 🧭 Naming conventions

- **Entities:** `*Entity.swift` (e.g., `MarketPairEntity`)
- **Enums:** `*Enum.swift` (e.g., `ProviderKeyEnum`)
- **Protocols:** `*Protocol.swift` (e.g., `RepositoryProtocol`)
- **Value Objects:** `*Value.swift` (e.g., `MoneyValue`)
- **Errors:** `*Error.swift` (e.g., `DomainError`)

---

## 🧪 Principles

1. **Isolation:** No imports from UI frameworks, persistence (CoreData/SQLite), or networking.
2. **Immutability:** Prefer `let` properties; “change” by creating new instances.
3. **Validation at boundaries:** Constructors (`init`) of ValueObjects/Entities validate input and throw `DomainError` (or return `Result`).
4. **No side-effects:** Domain doesn’t perform I/O, timers, or threads.
5. **Stable APIs:** Expose behavior through Entities/VO methods and Protocols.
6. **Testability:** Everything should be trivial to unit test with mocks/fakes.
7. **Serialization outside Domain:** Keep DTOs/mappers in Infrastructure/Transformers.

---

## ✅ Do & Don’t

**Do**
- Validate symbols/currencies at creation time.
- Keep behavior close to data (e.g., `MoneyValue.isGreaterThan(_:)`).
- Use protocols to express needs (provider, repository) without concrete types.

**Don’t**
- Reference `UIKit`, `SwiftUI`, `URLSession`, `FileManager`, `UserDefaults`, or DB types.
- Leak infrastructure errors (wrap as `DomainError`).
- Put formatting/localization here (leave to Transformers/UI).

---

## 🔌 How it fits in the app

- **Infrastructure** implements `CryptoProviderProtocol` and `RepositoryProtocol`.
- **Interaction/Services** orchestrate use cases, convert provider outputs to Domain models.
- **UI** binds to types conforming to `WidgetRenderableProtocol` (snapshots for rendering).

---

## 🧷 Example: constructing safe pairs

```swift
// VO construction validates raw input once.
let base = try TickerSymbolValue("BTC")
let quote = try TickerSymbolValue("USDT")

// Entity composes VOs and stays valid by design.
let pair = MarketPairEntity(base: base, quote: quote)
