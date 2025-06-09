# Architecture Document - Natural Match iOS

## 🏗 System Architecture Overview

Natural Match iOS follows a modern SwiftUI-based MVVM (Model-View-ViewModel) architecture with clean separation of concerns, dependency injection, and reactive programming patterns.

## 📱 High-Level Architecture

```
┌─────────────────────────────────────────────────────────┐
│                    Presentation Layer                   │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐     │
│  │   SwiftUI   │  │ View Models │  │ Navigation  │     │
│  │    Views    │◄─┤   (MVVM)    │◄─┤  Coordinators│     │
│  └─────────────┘  └─────────────┘  └─────────────┘     │
└─────────────────────────────────────────────────────────┘
                           │
┌─────────────────────────────────────────────────────────┐
│                    Business Layer                       │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐     │
│  │   Use Cases │  │   Services  │  │  Managers   │     │
│  │ (Interactors)│◄─┤(Auth, Match)│◄─┤(Data, Network)│   │
│  └─────────────┘  └─────────────┘  └─────────────┘     │
└─────────────────────────────────────────────────────────┘
                           │
┌─────────────────────────────────────────────────────────┐
│                     Data Layer                          │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐     │
│  │ Repositories│  │   Models    │  │   Storage   │     │
│  │ (Abstract)  │◄─┤  (Domain)   │◄─┤(Core Data,  │     │
│  └─────────────┘  └─────────────┘  │  Keychain)  │     │
└─────────────────────────────────────────────────────────┘
```

## 📂 Project Structure

```
NaturalMatch/
├── App/
│   ├── NaturalMatchApp.swift           # App entry point
│   └── AppDelegate.swift               # App lifecycle
│
├── Core/
│   ├── Models/                         # Domain models
│   │   ├── User.swift
│   │   ├── Profile.swift
│   │   ├── Match.swift
│   │   └── Message.swift
│   │
│   ├── Services/                       # Business services
│   │   ├── AuthenticationService.swift
│   │   ├── MatchingService.swift
│   │   ├── MessageService.swift
│   │   └── ProfileService.swift
│   │
│   └── Utilities/                      # Shared utilities
│       ├── Extensions/
│       ├── Constants.swift
│       └── Helpers/
│
├── Features/                           # Feature modules
│   ├── Authentication/
│   │   ├── Views/
│   │   │   ├── WelcomeView.swift      # ✅ Completed
│   │   │   ├── SignUpView.swift       # 📝 Next
│   │   │   └── SignInView.swift       # 📝 Next
│   │   │
│   │   ├── ViewModels/
│   │   │   ├── AuthenticationViewModel.swift
│   │   │   └── SignUpViewModel.swift
│   │   │
│   │   └── Models/
│   │       └── AuthenticationState.swift
│   │
│   ├── Profile/
│   │   ├── Views/
│   │   │   ├── ProfileCreationView.swift
│   │   │   ├── ProfileEditView.swift
│   │   │   └── ProfilePhotoUploadView.swift
│   │   │
│   │   ├── ViewModels/
│   │   │   └── ProfileViewModel.swift
│   │   │
│   │   └── Models/
│   │       └── ProfileData.swift
│   │
│   ├── Matching/
│   │   ├── Views/
│   │   │   ├── MatchDiscoveryView.swift
│   │   │   ├── MatchCardView.swift
│   │   │   └── MatchDetailsView.swift
│   │   │
│   │   ├── ViewModels/
│   │   │   └── MatchingViewModel.swift
│   │   │
│   │   └── Services/
│   │       └── MatchingAlgorithm.swift
│   │
│   └── Messaging/
│       ├── Views/
│       │   ├── ConversationListView.swift
│       │   ├── ChatView.swift
│       │   └── MessageBubbleView.swift
│       │
│       ├── ViewModels/
│       │   └── MessageViewModel.swift
│       │
│       └── Services/
│           └── MessageService.swift
│
├── Data/
│   ├── Repositories/                   # Data access layer
│   │   ├── UserRepository.swift
│   │   ├── MatchRepository.swift
│   │   └── MessageRepository.swift
│   │
│   ├── Storage/                        # Local storage
│   │   ├── CoreDataStack.swift
│   │   ├── KeychainManager.swift
│   │   └── UserDefaults+Extensions.swift
│   │
│   └── Network/                        # API layer (future)
│       ├── NetworkManager.swift
│       ├── APIEndpoints.swift
│       └── DTOs/
│
├── UI/                                 # Shared UI components
│   ├── Components/
│   │   ├── Buttons/
│   │   ├── Cards/
│   │   ├── Forms/
│   │   └── Navigation/
│   │
│   ├── Modifiers/
│   │   ├── ViewModifiers.swift
│   │   └── ButtonStyles.swift
│   │
│   └── Styles/
│       ├── Colors.swift
│       ├── Typography.swift
│       └── Spacing.swift
│
└── Resources/
    ├── Assets.xcassets/
    ├── Info.plist
    └── Supporting Files/
```

## 🔄 Data Flow Architecture

### MVVM Pattern Implementation

```
┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│    View     │───▶│ ViewModel   │───▶│   Service   │
│  (SwiftUI)  │    │(@Published) │    │ (Business)  │
└─────────────┘    └─────────────┘    └─────────────┘
        ▲                   ▲                   ▲
        │                   │                   │
        │            ┌─────────────┐    ┌─────────────┐
        └────────────│   @State    │    │ Repository  │
                     │ @Binding    │◄───│ (Data)      │
                     └─────────────┘    └─────────────┘
```

### State Management Flow

1. **User Interaction** → View captures user input
2. **Action Dispatch** → View calls ViewModel method
3. **Business Logic** → ViewModel processes via Services
4. **Data Operation** → Service calls Repository
5. **State Update** → Repository returns data to Service
6. **UI Update** → ViewModel publishes changes to View

## 📊 Core Models & Relationships

### User & Profile Model

```swift
// Domain Models
struct User: Identifiable, Codable {
    let id: UUID
    var email: String
    var profile: Profile?
    var authenticationState: AuthenticationState
    var createdAt: Date
    var lastActiveAt: Date
}

struct Profile: Codable {
    var name: String
    var age: Int
    var bio: String
    var photos: [Photo]
    var interests: [Interest]
    var personalityScore: PersonalityScore?
    var preferences: MatchingPreferences
    var completionPercentage: Double
}

struct Match: Identifiable, Codable {
    let id: UUID
    let userId: UUID
    let matchedUserId: UUID
    let compatibilityScore: Double
    let matchedAt: Date
    let status: MatchStatus
    let conversation: Conversation?
}
```

### Relationship Diagram

```
    User (1) ←→ (1) Profile
      │
      │ (1)
      ↓
      │ (N) Match
      │
      │ (1)
      ↓
      └→ (1) Conversation ←→ (N) Message
```

## 🛡 Security Architecture

### Authentication Flow

```
┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│   Sign Up   │───▶│  Validation │───▶│  Keychain   │
│   Screen    │    │   Service   │    │   Storage   │
└─────────────┘    └─────────────┘    └─────────────┘
        │                   │                   │
        ▼                   ▼                   ▼
┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│   Sign In   │───▶│    Auth     │───▶│  Session    │
│   Screen    │    │  Manager    │    │  Manager    │
└─────────────┘    └─────────────┘    └─────────────┘
```

### Data Protection

- **Keychain**: Secure credential storage
- **UserDefaults**: Non-sensitive settings only
- **Core Data**: Encrypted local profile data
- **Memory**: Sensitive data cleared on logout

## 🔌 Dependency Injection

### Service Container Pattern

```swift
// Dependency container
class ServiceContainer: ObservableObject {
    // Singletons
    lazy var authService = AuthenticationService()
    lazy var profileService = ProfileService()
    lazy var matchingService = MatchingService()
    
    // Repositories
    lazy var userRepository = UserRepository()
    lazy var matchRepository = MatchRepository()
    
    // Storage
    lazy var keychainManager = KeychainManager()
    lazy var coreDataStack = CoreDataStack()
}

// Usage in Views
struct ContentView: View {
    @EnvironmentObject var services: ServiceContainer
    
    var body: some View {
        // View implementation
    }
}
```

## 📱 Navigation Architecture

### Coordinator Pattern

```swift
// Navigation flow management
class AppCoordinator: ObservableObject {
    @Published var currentFlow: AppFlow = .welcome
    
    enum AppFlow {
        case welcome
        case authentication
        case profileCreation
        case mainApp
    }
}

// Flow-specific coordinators
class AuthenticationCoordinator: ObservableObject {
    @Published var currentScreen: AuthScreen = .signUp
    
    enum AuthScreen {
        case signUp
        case signIn
        case forgotPassword
    }
}
```

## 🎨 UI Architecture

### Design System Components

```
UI Components Hierarchy:
├── Atoms (Basic elements)
│   ├── NMButton
│   ├── NMTextField
│   └── NMCard
│
├── Molecules (Combined atoms)
│   ├── LoginForm
│   ├── PhotoGrid
│   └── MatchCard
│
└── Organisms (Feature components)
    ├── ProfileCreationFlow
    ├── MatchDiscovery
    └── ConversationView
```

### Theme & Styling

```swift
// Centralized styling
struct NaturalMatchTheme {
    static let primary = Color.pink
    static let secondary = Color.coral
    static let background = Color.white
    static let surface = Color.gray100
    
    static let titleFont = Font.largeTitle.weight(.bold)
    static let bodyFont = Font.body
    static let captionFont = Font.caption
}
```

## 🔄 Reactive Programming

### Combine Integration

```swift
class ProfileViewModel: ObservableObject {
    @Published var profile = Profile()
    @Published var isLoading = false
    @Published var error: Error?
    
    private var cancellables = Set<AnyCancellable>()
    private let profileService: ProfileService
    
    func updateProfile() {
        isLoading = true
        
        profileService.updateProfile(profile)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    self?.isLoading = false
                    if case .failure(let error) = completion {
                        self?.error = error
                    }
                },
                receiveValue: { [weak self] updatedProfile in
                    self?.profile = updatedProfile
                }
            )
            .store(in: &cancellables)
    }
}
```

## 📋 Technical Decisions

### Architecture Choices

| Decision | Rationale | Trade-offs |
|----------|-----------|------------|
| **SwiftUI + MVVM** | Modern, reactive, declarative UI | Learning curve, iOS 14+ only |
| **Combine** | Native reactive programming | Complex debugging |
| **Core Data** | Robust local persistence | Setup complexity |
| **Dependency Injection** | Testable, maintainable code | Initial setup overhead |

### Performance Considerations

- **Lazy Loading**: ViewModels and Services
- **Image Caching**: Profile photos optimization
- **Data Pagination**: Large match lists
- **Background Processing**: Matching algorithm

## 🧪 Testing Strategy

### Test Architecture

```
Testing Layers:
├── Unit Tests
│   ├── ViewModels
│   ├── Services
│   └── Utilities
│
├── Integration Tests
│   ├── Data Flow
│   ├── Navigation
│   └── Service Integration
│
└── UI Tests
    ├── Critical User Flows
    ├── Authentication
    └── Profile Creation
```

---

*Document Version: 1.0*
*Last Updated: Initial creation*
*Review Cycle: After each major feature completion* 