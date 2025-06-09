# Architecture Document - Natural Match iOS

## 🏗 System Architecture Overview

Natural Match iOS is a voice-first, location-aware dating app built around **Birdie**, an AI assistant that guides users through proximity-based matching. The architecture integrates SwiftUI, GPT-4o, Supabase, and location services for a revolutionary dating experience.

## 📱 High-Level Architecture

```
┌─────────────────────────────────────────────────────────┐
│                  Presentation Layer                     │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐     │
│  │   SwiftUI   │  │   Birdie    │  │  Location   │     │
│  │  (Minimal)  │◄─┤    Chat     │◄─┤   Views     │     │
│  └─────────────┘  └─────────────┘  └─────────────┘     │
└─────────────────────────────────────────────────────────┘
                           │
┌─────────────────────────────────────────────────────────┐
│                    AI & Voice Layer                     │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐     │
│  │   GPT-4o    │  │   Whisper   │  │ Personality │     │
│  │ Integration │◄─┤ ASR + TTS   │◄─┤   Tagging   │     │
│  └─────────────┘  └─────────────┘  └─────────────┘     │
└─────────────────────────────────────────────────────────┘
                           │
┌─────────────────────────────────────────────────────────┐
│                  Location & Matching                    │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐     │
│  │CoreLocation │  │   Proximity │  │  UWB/BLE    │     │
│  │  Tracking   │◄─┤   Engine    │◄─┤(NearbyInt.) │     │
│  └─────────────┘  └─────────────┘  └─────────────┘     │
└─────────────────────────────────────────────────────────┘
                           │
┌─────────────────────────────────────────────────────────┐
│                   Backend (Supabase)                    │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐     │
│  │ Postgres 16 │  │   Storage   │  │  Realtime   │     │
│  │   + Auth    │◄─┤ (Media/Tags)│◄─┤    Chat     │     │
│  └─────────────┘  └─────────────┘  └─────────────┘     │
└─────────────────────────────────────────────────────────┘
```

## 📂 Project Structure

```
NaturalMatch/
├── App/
│   ├── NaturalMatchApp.swift           # App entry point
│   └── AppDelegate.swift               # Location permissions & lifecycle
│
├── Core/
│   ├── Models/                         # Domain models
│   │   ├── User.swift
│   │   ├── PersonalityProfile.swift    # 250+ tags + GPT bio
│   │   ├── ProximityMatch.swift        # Location-based matching
│   │   ├── Hint.swift                  # Daily venue suggestions
│   │   └── IntroVideo.swift            # 3-second recordings
│   │
│   ├── Services/                       # Core services
│   │   ├── SupabaseService.swift       # Backend integration
│   │   ├── BirdieService.swift         # AI assistant orchestration
│   │   ├── LocationService.swift       # CoreLocation + proximity
│   │   ├── VoiceService.swift          # Whisper ASR + TTS
│   │   └── PersonalityService.swift    # GPT-4o tagging + matching
│   │
│   └── Utilities/                      # Shared utilities
│       ├── Extensions/
│       ├── LocationHasher.swift        # 4-decimal GPS hashing
│       ├── VoiceRecorder.swift         # Audio capture
│       └── VideoRecorder.swift         # 3-sec intro videos
│
├── Features/                           # Feature modules
│   ├── Onboarding/
│   │   ├── Views/
│   │   │   ├── WelcomeView.swift      # ✅ Completed
│   │   │   ├── BirdieIntakeView.swift # 📝 Voice-guided Q&A
│   │   │   └── VideoRecordingView.swift # 📝 3-sec intro
│   │   │
│   │   ├── ViewModels/
│   │   │   ├── OnboardingViewModel.swift
│   │   │   └── PersonalityIntakeViewModel.swift
│   │   │
│   │   └── Models/
│   │       └── OnboardingState.swift
│   │
│   ├── BirdieChat/
│   │   ├── Views/
│   │   │   ├── BirdieChatView.swift    # Main chat interface
│   │   │   ├── VoiceInputView.swift    # Voice interaction
│   │   │   └── HintDisplayView.swift   # Daily venue hints
│   │   │
│   │   ├── ViewModels/
│   │   │   └── BirdieChatViewModel.swift
│   │   │
│   │   └── Services/
│   │       ├── ConversationManager.swift
│   │       └── GPTIntegration.swift
│   │
│   ├── ProximityMatching/
│   │   ├── Views/
│   │   │   ├── ProximityAlertView.swift    # ¼-mile reveal
│   │   │   ├── MatchRevealView.swift       # Bio/photo/video reveal
│   │   │   └── MeetupCoordinationView.swift # Mutual meet flow
│   │   │
│   │   ├── ViewModels/
│   │   │   └── ProximityViewModel.swift
│   │   │
│   │   └── Services/
│   │       ├── ProximityEngine.swift       # Location monitoring
│   │       ├── MatchingAlgorithm.swift     # Cosine similarity
│   │       └── UWBService.swift            # Phase 2: Sub-10m precision
│   │
│   └── ActiveMatches/
│       ├── Views/
│       │   ├── MatchCapView.swift          # 3-match limit UI
│       │   ├── MatchArchiveView.swift      # Archive to accept new
│       │   └── MutualMeetView.swift        # Precise meetup spots
│       │
│       ├── ViewModels/
│       │   └── MatchManagementViewModel.swift
│       │
│       └── Services/
│           └── MatchLifecycleService.swift
│
├── AI/                                 # AI integration layer
│   ├── GPT/
│   │   ├── GPTClient.swift             # OpenAI API wrapper
│   │   ├── PersonalityTagger.swift     # Generate 250+ tags
│   │   ├── BioGenerator.swift          # 40-60 word bios
│   │   └── HintGenerator.swift         # Venue suggestions
│   │
│   ├── Voice/
│   │   ├── WhisperService.swift        # Speech-to-text
│   │   ├── TTSService.swift            # Text-to-speech
│   │   └── VoiceModerationService.swift # Content filtering
│   │
│   └── Matching/
│       ├── CompatibilityScorer.swift   # Cosine similarity engine
│       ├── RoutineAnalyzer.swift       # Location pattern analysis
│       └── HintTrigger.swift           # 60% overlap threshold
│
├── Location/                           # Location services
│   ├── Managers/
│   │   ├── LocationManager.swift       # CoreLocation wrapper
│   │   ├── ProximityDetector.swift     # ¼-mile detection
│   │   └── UWBManager.swift            # Phase 2: Ultra-wideband
│   │
│   ├── Models/
│   │   ├── LocationHash.swift          # Privacy-preserving coords
│   │   ├── ProximityEvent.swift        # Reveal triggers
│   │   └── RoutinePattern.swift        # Movement analysis
│   │
│   └── Privacy/
│       ├── LocationHasher.swift        # 4-decimal precision
│       ├── DataRetentionPolicy.swift   # 24h GPS cleanup
│       └── ConsentManager.swift        # Location permissions
│
├── Backend/                            # Supabase integration
│   ├── SupabaseClient.swift            # Main client wrapper
│   ├── Auth/
│   │   ├── AuthenticationManager.swift # Supabase Auth
│   │   └── AgeVerificationService.swift # Apple Pay + ID scan
│   │
│   ├── Database/
│   │   ├── UserRepository.swift
│   │   ├── PersonalityRepository.swift  # JSONB tag storage
│   │   ├── MatchRepository.swift
│   │   └── HintRepository.swift
│   │
│   ├── Storage/
│   │   ├── MediaUploadService.swift     # Photos + videos
│   │   ├── VideoStorageManager.swift    # 3-sec intros
│   │   └── AutoDeletionService.swift    # 30/90-day cleanup
│   │
│   └── Realtime/
│       ├── BirdieChatChannel.swift      # Live conversation
│       ├── ProximityChannel.swift       # Location updates
│       └── MatchNotificationChannel.swift # Real-time alerts
│
├── UI/                                 # Minimal UI components
│   ├── Components/
│   │   ├── VoiceButton.swift           # Primary interaction
│   │   ├── ProximityIndicator.swift    # Distance visualization
│   │   ├── VideoPlayer.swift           # 3-sec intro playback
│   │   └── BirdieAvatar.swift          # AI assistant visual
│   │
│   ├── Styles/
│   │   ├── VoiceFirstTheme.swift       # Minimal chrome design
│   │   ├── ProximityColors.swift       # Distance-based UI
│   │   └── BirdiePersonality.swift     # AI assistant styling
│   │
│   └── Modifiers/
│       ├── VoiceAnimations.swift       # Speaking indicators
│       └── ProximityAnimations.swift   # Reveal transitions
│
└── Resources/
    ├── Assets.xcassets/
    ├── Info.plist                      # Location permissions
    ├── BirdieVoices/                   # TTS voice assets
    └── PrivacyPolicy.md                # GDPR/CCPA compliance
```

## 🔄 Data Flow Architecture

### Voice-First Interaction Flow

```
┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│    User     │───▶│   Birdie    │───▶│   GPT-4o    │
│   (Voice)   │    │    Chat     │    │     API     │
└─────────────┘    └─────────────┘    └─────────────┘
        ▲                   │                   │
        │                   ▼                   ▼
        │            ┌─────────────┐    ┌─────────────┐
        └────────────│ Text-to-    │    │ Personality │
                     │ Speech      │◄───│   Tagging   │
                     └─────────────┘    └─────────────┘
```

### Proximity-Based Matching Flow

```
   ┌─────────────┐         ┌─────────────┐         ┌─────────────┐
   │ Location    │────────▶│ Proximity   │────────▶│   Match     │
   │ Tracking    │         │ Detection   │         │  Reveal     │
   └─────────────┘         └─────────────┘         └─────────────┘
          │                        │                        │
          ▼                        ▼                        ▼
   ┌─────────────┐         ┌─────────────┐         ┌─────────────┐
   │  GPS Hash   │         │  ≤ ¼ Mile   │         │  Bio +      │
   │ (4-decimal) │         │  Trigger    │         │  Video      │
   └─────────────┘         └─────────────┘         └─────────────┘
```

### AI-Driven State Management

1. **Voice Input** → Whisper ASR converts speech to text
2. **GPT Processing** → GPT-4o analyzes and responds
3. **Personality Analysis** → Generate 250+ tags from conversation
4. **Location Monitoring** → Continuous proximity detection
5. **Hint Generation** → Daily venue suggestions when compatible users nearby
6. **Match Reveal** → Simultaneous profile reveal at ¼-mile proximity

## 📊 Core Models & Relationships

### Core Domain Models

```swift
// User & Personality
struct User: Identifiable, Codable {
    let id: UUID
    var email: String
    var personalityProfile: PersonalityProfile?
    var authenticationState: AuthenticationState
    var locationHash: String?            // 4-decimal GPS hash
    var activeMatchCount: Int = 0        // Max 3 matches
    var createdAt: Date
    var lastActiveAt: Date
}

struct PersonalityProfile: Codable {
    var name: String
    var age: Int
    var introVideo: IntroVideo           // 3-second recording
    var personalityTags: [String]        // 250+ GPT-generated tags
    var gptGeneratedBio: String          // 40-60 words, hidden until reveal
    var onboardingCompletedAt: Date
    var bioGeneratedAt: Date
}

struct IntroVideo: Codable {
    let id: UUID
    let supabaseUrl: String              // Signed URL from Supabase Storage
    let duration: TimeInterval           // ~3 seconds
    let createdAt: Date
    let expirationDate: Date             // Auto-delete after 30/90 days
}

// Location & Proximity
struct ProximityMatch: Identifiable, Codable {
    let id: UUID
    let userId: UUID
    let potentialMatchId: UUID
    let compatibilityScore: Double       // Cosine similarity of tags
    let lastProximityDetected: Date?     // When within ¼ mile
    let revealTriggered: Bool            // Simultaneous reveal flag
    let mutualMeetRequested: Bool
    let status: ProximityMatchStatus
    var archivedAt: Date?                // When user archives match
}

enum ProximityMatchStatus: String, Codable {
    case potential     // Compatible but not yet revealed
    case hintSent      // Daily hint sent to user
    case revealed      // ¼-mile proximity triggered reveal
    case mutualMeet    // Both users said "Yes" to meet
    case archived      // User archived to accept new matches
    case expired       // Auto-expired after inactivity
}

// Daily Hints & Birdie Interaction
struct Hint: Identifiable, Codable {
    let id: UUID
    let userId: UUID
    let potentialMatchId: UUID
    let venueName: String                // "Blue Bottle Coffee"
    let areaHint: String                 // "near the BART station"
    let hintText: String                 // GPT-generated suggestion
    let sentAt: Date
    let isViewed: Bool
    var proximityDetectedAfterHint: Bool // Tracking hint effectiveness
}

struct BirdieConversation: Identifiable, Codable {
    let id: UUID
    let userId: UUID
    var messages: [BirdieMessage]
    var onboardingProgress: OnboardingProgress
    var createdAt: Date
    var lastInteractionAt: Date
}

struct BirdieMessage: Identifiable, Codable {
    let id: UUID
    var content: String
    var isFromBirdie: Bool               // true = Birdie, false = User
    var messageType: BirdieMessageType
    var timestamp: Date
    var voiceData: Data?                 // Audio recording (if voice input)
}

enum BirdieMessageType: String, Codable {
    case onboardingQuestion
    case userResponse
    case personalityInsight
    case dailyHint
    case meetupCoordination
    case generalChat
}
```

### Entity Relationship Diagram

```
    User (1) ←→ (1) PersonalityProfile
      │                    │
      │                    └──→ (1) IntroVideo
      │
      │ (1)                     
      ↓                        
    BirdieConversation (1) ←→ (N) BirdieMessage
      │
      │ (1)
      ↓
    User (1) ←→ (N) ProximityMatch ←→ (1) User (potential)
      │                    │
      │                    └──→ (N) Hint
      │
      │ (N)
      ↓
    LocationHash (tracking movement patterns)
```

### Location Privacy Model

```swift
struct LocationHash: Codable {
    let id: UUID
    let userId: UUID
    let hashedCoordinates: String        // 4-decimal precision hash
    let timestamp: Date
    let routinePattern: RoutinePattern?  // Commute analysis
    var deletedAt: Date?                 // Auto-delete after 24h
}

struct RoutinePattern: Codable {
    var commonLocations: [String]        // Hashed frequent locations
    var timePatterns: [TimePattern]      // When user is usually there
    var overlapProbability: Double       // % chance of crossing paths
}

struct TimePattern: Codable {
    var locationHash: String
    var dayOfWeek: Int                   // 1-7
    var timeRange: ClosedRange<Int>      // Hour of day (0-23)
    var frequency: Double                // How often (0.0-1.0)
}
```

## 🛡 Security & Privacy Architecture

### Location Privacy Flow

```
┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│   Raw GPS   │───▶│  Hash to    │───▶│  Supabase   │
│Coordinates  │    │ 4-decimal   │    │  Storage    │
└─────────────┘    └─────────────┘    └─────────────┘
        │                   │                   │
        ▼                   ▼                   ▼
┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│Delete after │    │ Proximity   │    │Auto-delete │
│   24 hours  │    │ Detection   │    │after 24h   │
└─────────────┘    └─────────────┘    └─────────────┘
```

### Voice Data Security

```
┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│ Voice Input │───▶│  Whisper    │───▶│   Text      │
│(Temporary)  │    │   ASR       │    │Processing   │
└─────────────┘    └─────────────┘    └─────────────┘
        │                   │                   │
        ▼                   ▼                   ▼
┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│Auto-delete  │    │ GPT-4o API  │    │ Tags +      │
│  < 60 sec   │    │(Moderated)  │    │ Bio Gen     │
└─────────────┘    └─────────────┘    └─────────────┘
```

### Data Protection Layers

| Data Type | Storage | Retention | Protection |
|-----------|---------|-----------|------------|
| **Raw GPS** | Device only | 24 hours | Immediate deletion |
| **Location Hash** | Supabase | 24 hours | 4-decimal precision |
| **Voice Data** | Device only | < 60 seconds | ASR then purge |
| **Personality Tags** | Supabase | Indefinite | JSONB encrypted |
| **Intro Videos** | Supabase Storage | 30/90 days | Signed URLs |
| **Chat Messages** | Supabase | User-controlled | End-to-end option |
| **Biometrics** | Secure Enclave | Session only | Apple TouchID/FaceID |

### Age Verification & Safety

- **Apple Pay Token**: Verify 18+ without storing payment info
- **ID Scanning**: Apple Vision framework for document verification
- **Moderation Pipeline**: All GPT outputs pass OpenAI moderation API
- **Report System**: Immediate blocking + human review within 24h
- **Location Consent**: Explicit opt-in for each proximity level
- **Data Export**: GDPR/CCPA compliant within 30 days

## 🔌 Dependency Injection

### AI-First Service Container

```swift
// Dependency container for Natural Match
class NaturalMatchContainer: ObservableObject {
    // AI Services
    lazy var birdieService = BirdieService(gptClient: gptClient, voiceService: voiceService)
    lazy var gptClient = GPTClient(apiKey: Configuration.openAIKey)
    lazy var voiceService = VoiceService()
    lazy var personalityService = PersonalityService(gptClient: gptClient)
    
    // Location Services
    lazy var locationService = LocationService()
    lazy var proximityDetector = ProximityDetector(locationService: locationService)
    lazy var locationHasher = LocationHasher()
    
    // Backend Services
    lazy var supabaseClient = SupabaseClient(url: Configuration.supabaseUrl, key: Configuration.supabaseKey)
    lazy var authManager = AuthenticationManager(supabase: supabaseClient)
    
    // Repositories
    lazy var userRepository = UserRepository(supabase: supabaseClient)
    lazy var personalityRepository = PersonalityRepository(supabase: supabaseClient)
    lazy var matchRepository = MatchRepository(supabase: supabaseClient)
    lazy var hintRepository = HintRepository(supabase: supabaseClient)
    
    // Matching Engine
    lazy var compatibilityScorer = CompatibilityScorer()
    lazy var routineAnalyzer = RoutineAnalyzer(locationService: locationService)
    lazy var hintTrigger = HintTrigger(scorer: compatibilityScorer, analyzer: routineAnalyzer)
    
    // Media Services
    lazy var videoRecorder = VideoRecorder()
    lazy var mediaUploadService = MediaUploadService(supabase: supabaseClient)
    lazy var autoDeletionService = AutoDeletionService(supabase: supabaseClient)
}

// Usage in SwiftUI App
@main
struct NaturalMatchApp: App {
    @StateObject private var container = NaturalMatchContainer()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(container)
        }
    }
}
```

## 📱 Navigation Architecture

### Voice-First Navigation Flow

```swift
// Birdie-guided navigation
class AppFlowCoordinator: ObservableObject {
    @Published var currentFlow: AppFlow = .welcome
    @Published var birdieGuidedStep: BirdieStep = .initial
    
    enum AppFlow {
        case welcome
        case birdieOnboarding    // 10-30 min guided conversation
        case videoRecording      // 3-second intro
        case waitingForMatches   // Background location monitoring
        case proximityAlert      // ¼-mile detected
        case matchReveal         // Simultaneous profile reveal
        case meetupCoordination  // Birdie helps coordinate meetup
    }
    
    enum BirdieStep {
        case initial
        case personalityQuestions
        case bioGeneration
        case onboardingComplete
        case dailyHintSent
        case proximityDetected
        case mutualMeetRequested
    }
}

// Location-based navigation triggers
class ProximityNavigationManager: ObservableObject {
    @Published var shouldShowProximityAlert = false
    @Published var activeProximityMatch: ProximityMatch?
    @Published var revealStep: RevealStep = .none
    
    enum RevealStep {
        case none
        case approaching         // Getting close to ¼ mile
        case triggered          // Simultaneous reveal happening
        case revealed           // Bio + video shown
        case meetDecisionPending // Waiting for "Meet?" response
        case meetupCoordinated  // Birdie providing directions
    }
}
```

## 🎨 UI Architecture

### Voice-First Minimal Design System

```
UI Components Hierarchy (Minimal Chrome):
├── Voice Interaction
│   ├── VoiceButton (Primary interaction)
│   ├── BirdieAvatar (Speaking indicator)
│   └── VoiceWaveform (Visual feedback)
│
├── Proximity Awareness
│   ├── ProximityIndicator (Distance visualization)
│   ├── LocationPermissionCard
│   └── RevealAnimation (¼-mile trigger)
│
├── Match Revelation
│   ├── IntroVideoPlayer (3-second reveal)
│   ├── GPTGeneratedBio (40-60 words)
│   └── MeetButton (Mutual meetup)
│
└── Birdie Chat
    ├── BirdieMessageBubble
    ├── HintCard (Daily venue suggestions)
    └── OnboardingProgress
```

### Voice-First Theme

```swift
// Minimal UI theme optimized for voice interaction
struct BirdieTheme {
    // Colors
    static let primary = Color.blue          // Birdie's personality
    static let secondary = Color.teal        // Proximity states
    static let background = Color.black      // Dark mode primary
    static let surface = Color.gray900       // Card backgrounds
    static let accent = Color.yellow         // Active voice input
    
    // Typography (Large, readable)
    static let birdieFont = Font.title2.weight(.medium)    // Birdie messages
    static let userFont = Font.title3.weight(.regular)     // User responses
    static let hintFont = Font.headline.weight(.semibold)  // Daily hints
    static let bioFont = Font.body.weight(.regular)        // GPT-generated bios
    
    // Voice Interaction
    static let voiceButtonSize: CGFloat = 80
    static let listeningPulse = Animation.easeInOut(duration: 1.5).repeatForever()
    static let speakingWave = Animation.linear(duration: 0.3).repeatForever()
    
    // Proximity Colors
    static let proximityFar = Color.gray      // >1 mile
    static let proximityNear = Color.orange   // <1 mile
    static let proximityClose = Color.red     // <¼ mile (reveal)
    static let proximityMeet = Color.green    // Mutual meet
}

// Dynamic proximity-based styling
extension Color {
    static func proximityColor(for distance: CLLocationDistance) -> Color {
        switch distance {
        case 0..<400:       return BirdieTheme.proximityClose     // ¼ mile
        case 400..<1600:    return BirdieTheme.proximityNear      // 1 mile
        default:            return BirdieTheme.proximityFar
        }
    }
}
```

## 🔄 Reactive Programming

### AI & Location-Driven Reactive Flow

```swift
// Birdie conversation flow with voice processing
class BirdieChatViewModel: ObservableObject {
    @Published var messages: [BirdieMessage] = []
    @Published var isListening = false
    @Published var isProcessing = false
    @Published var onboardingProgress: Double = 0.0
    
    private var cancellables = Set<AnyCancellable>()
    private let birdieService: BirdieService
    private let voiceService: VoiceService
    
    func startVoiceInput() {
        isListening = true
        
        voiceService.startRecording()
            .flatMap { [weak self] audioData in
                self?.birdieService.processVoiceInput(audioData) ?? Empty().eraseToAnyPublisher()
            }
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    self?.isListening = false
                    self?.isProcessing = false
                },
                receiveValue: { [weak self] response in
                    self?.addBirdieMessage(response)
                    self?.updateOnboardingProgress()
                }
            )
            .store(in: &cancellables)
    }
}

// Location-based proximity detection
class ProximityDetectionViewModel: ObservableObject {
    @Published var nearbyMatches: [ProximityMatch] = []
    @Published var activeReveal: ProximityMatch?
    @Published var dailyHint: Hint?
    
    private var cancellables = Set<AnyCancellable>()
    private let proximityDetector: ProximityDetector
    private let hintTrigger: HintTrigger
    
    func startLocationMonitoring() {
        // Monitor for proximity events
        proximityDetector.proximityEvents
            .filter { $0.distance <= 400 } // ¼ mile threshold
            .receive(on: DispatchQueue.main)
            .sink { [weak self] event in
                self?.triggerMatchReveal(for: event.matchId)
            }
            .store(in: &cancellables)
        
        // Generate daily hints
        hintTrigger.dailyHints
            .receive(on: DispatchQueue.main)
            .sink { [weak self] hint in
                self?.dailyHint = hint
                self?.sendHintToBirdieChat(hint)
            }
            .store(in: &cancellables)
    }
}

// GPT-4o personality analysis pipeline
class PersonalityAnalysisViewModel: ObservableObject {
    @Published var personalityTags: [String] = []
    @Published var generatedBio: String = ""
    @Published var compatibilityScores: [UUID: Double] = [:]
    
    private var cancellables = Set<AnyCancellable>()
    private let personalityService: PersonalityService
    
    func analyzeConversation(_ messages: [BirdieMessage]) {
        personalityService.generatePersonalityTags(from: messages)
            .flatMap { [weak self] tags in
                self?.personalityTags = tags
                return self?.personalityService.generateBio(from: tags) ?? Empty().eraseToAnyPublisher()
            }
            .flatMap { [weak self] bio in
                self?.generatedBio = bio
                return self?.personalityService.calculateCompatibilityScores(for: self?.personalityTags ?? []) ?? Empty().eraseToAnyPublisher()
            }
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { completion in
                    // Handle completion
                },
                receiveValue: { [weak self] scores in
                    self?.compatibilityScores = scores
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
| **GPT-4o + Whisper** | Industry-leading AI for personality analysis | Cost per API call, latency |
| **Supabase** | Real-time features, GDPR compliance | Vendor lock-in, learning curve |
| **SwiftUI iOS 17+** | Modern UI with voice/location features | Limited device compatibility |
| **CoreLocation + UWB** | Precise proximity detection | Battery usage, privacy concerns |
| **Voice-First Design** | Minimal screen time, natural interaction | Accessibility challenges |
| **No Local ML** | Faster development, latest AI models | Internet dependency |

### Performance Considerations

- **Location Batching**: Update GPS every 30 seconds max
- **Voice Processing**: 3-second timeout for ASR
- **GPT Caching**: Cache personality tags and bios
- **Media Compression**: 3-second videos <2MB
- **Background Processing**: Location monitoring in background
- **Proximity Algorithms**: Efficient distance calculations
- **Battery Optimization**: Significant location changes only

### Cost Management

| Component | Estimated Cost/User/Month | Optimization |
|-----------|---------------------------|--------------|
| **GPT-4o API** | $2-5 (onboarding + hints) | Cache responses, batch requests |
| **Whisper ASR** | $0.10-0.50 | 3-sec clips only |
| **Supabase** | $0.20-1.00 | Auto-delete old data |
| **Location Services** | $0.05 | Batch updates, power efficiency |

### Privacy by Design

- **Data Minimization**: Only collect what's needed for matching
- **Purpose Limitation**: Location only for proximity detection
- **Storage Limitation**: Auto-delete GPS after 24h
- **Transparency**: Clear consent for each feature
- **User Control**: Export/delete data anytime

## 🧪 Testing Strategy

### AI-First Testing Pyramid

```
                        ▲
                       /|\
                      / | \
                     /  |  \
                    /E2E|   \
                   /Voice|    \
                  /Tests|     \
                 /______|______\
                /  AI/Location  \
               /Integration Tests\
              /__________________\
             /                    \
            /   Unit Tests +       \
           /  Mock AI Responses    \
          /______________________ \
```

### Specialized Test Coverage

| Test Type | Focus Area | Coverage Goal |
|-----------|------------|---------------|
| **Voice Tests** | Whisper ASR accuracy | 95% recognition |
| **AI Mock Tests** | GPT-4o response handling | 100% edge cases |
| **Location Tests** | Proximity detection accuracy | 99% within ±50m |
| **Privacy Tests** | Data deletion compliance | 100% requirements |
| **Performance Tests** | Voice latency <3s | 95th percentile |
| **Battery Tests** | Background location impact | <5% drain/hour |

### Test Data Strategy

- **Synthetic Personalities**: Pre-generated tag sets for consistent testing
- **Location Simulation**: Virtual GPS coordinates for proximity testing
- **Voice Test Clips**: Recorded samples for ASR accuracy
- **Mock GPT Responses**: Cached AI outputs for predictable tests
- **Privacy Compliance**: Automated GDPR/CCPA deletion verification

### Testing Architecture

```swift
// Mock AI services for predictable testing
class MockBirdieService: BirdieService {
    var mockResponses: [String] = []
    var mockPersonalityTags: [String] = []
    var shouldSimulateLatency: Bool = false
    
    override func processVoiceInput(_ audioData: Data) -> AnyPublisher<BirdieResponse, Error> {
        if shouldSimulateLatency {
            return Just(BirdieResponse(content: mockResponses.randomElement() ?? ""))
                .delay(for: .seconds(2), scheduler: RunLoop.main)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        
        return Just(BirdieResponse(content: mockResponses.randomElement() ?? ""))
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}

// Location simulation for proximity testing
class MockLocationService: LocationService {
    var simulatedCoordinate: CLLocationCoordinate2D?
    var simulatedDistance: CLLocationDistance = 1000
    
    func simulateMovement(to coordinate: CLLocationCoordinate2D) {
        simulatedCoordinate = coordinate
        // Trigger proximity events for testing
    }
}

// Performance and battery testing
class PerformanceTestSuite: XCTestCase {
    func testVoiceProcessingLatency() {
        // Measure time from voice input to GPT response
        measure {
            // Voice processing test
        }
    }
    
    func testLocationBatteryImpact() {
        // Monitor battery usage during location tracking
    }
}
```

---

*Document Version: 2.0*  
*Last Updated: Aligned with Voice-First PRD*  
*Review Cycle: After each sprint completion* 