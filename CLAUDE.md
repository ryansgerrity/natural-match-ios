# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

### Build and Run
```bash
# Open in Xcode
open NaturalMatch/NaturalMatch.xcodeproj

# Build from command line
xcodebuild -project NaturalMatch/NaturalMatch.xcodeproj -scheme NaturalMatch -destination 'platform=iOS Simulator,name=iPhone 16'

# Run tests
xcodebuild test -project NaturalMatch/NaturalMatch.xcodeproj -scheme NaturalMatch -destination 'platform=iOS Simulator,name=iPhone 16'

# Clean build folder
xcodebuild clean -project NaturalMatch/NaturalMatch.xcodeproj -scheme NaturalMatch
```

### Development Workflow
The project uses a unique AI-assisted development workflow where tasks are selected from the backlog and implemented:
1. Check `ai_ctx/backlog.md` for current task status
2. Tasks marked "in-dev" are being worked on
3. Update task status when starting/completing work
4. Follow the 1 story point per task guideline

## Architecture Overview

**NaturalMatch** is a voice-first dating iOS app built around "Birdie", an AI assistant that eliminates swiping and focuses on proximity-based authentic connections.

### Core Concepts
- **Voice-First**: Birdie guides users through 10-30 minute conversational onboarding via GPT-4o
- **No Swiping**: Profiles remain hidden until users are within ¼ mile proximity
- **Quality Over Quantity**: Users limited to 3 active matches to encourage meaningful connections
- **Privacy-First**: Location data is hashed to 4-decimal precision and auto-deleted after 24 hours

### Technology Stack
- **Frontend**: SwiftUI (iOS 17+) with minimal UI chrome
- **AI**: OpenAI GPT-4o for personality analysis + Whisper ASR for voice
- **Backend**: Supabase (Postgres, Auth, Storage, Realtime)
- **Location**: CoreLocation for proximity detection, NearbyInteraction (UWB) planned for Phase 2

### Key Features Being Built
1. **Birdie Voice Onboarding**: AI-guided personality intake generating 250+ tags
2. **GPT-Generated Bios**: 40-60 word bios created from personality analysis
3. **Proximity Matching**: Simultaneous profile reveal when users within ¼ mile
4. **Daily Hints**: One venue suggestion per day when high compatibility detected
5. **3-Second Intro Videos**: Quick video recordings for authentic first impressions

### Project Structure
```
NaturalMatch/
├── App/                    # App entry point & lifecycle
├── Core/                   # Models, Services, Utilities
├── Features/               # Feature modules (Onboarding, BirdieChat, etc.)
├── AI/                     # GPT, Voice, Matching algorithms
├── Location/               # CoreLocation & proximity services
├── Backend/                # Supabase integration
├── UI/                     # Minimal SwiftUI components
└── Resources/              # Assets, configs, privacy policies
```

### Current Development Status
- **TKT-01** (Birdie Voice-First Onboarding) is in development
- **TASK-011** (BirdieChatView UI) is completed
- **TASK-012** (Birdie avatar with speaking states) is currently being implemented

### Important Implementation Notes
- Every feature should prioritize voice interaction over touch UI
- Location data must be hashed and follow strict 24-hour retention policy
- The app relies heavily on GPT-4o for personality analysis and content generation
- Maintain minimal visual chrome - let Birdie guide the experience
- All media (videos/photos) auto-delete after 30 days (unmatched) or 90 days (archived)