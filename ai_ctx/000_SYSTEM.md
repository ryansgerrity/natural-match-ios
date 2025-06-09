# AI Context Charter - Natural Match iOS

## Actors  
• **Gemini 2.5 Pro** — Reads all files in `/ai_ctx`; produces ≤10k-token briefings for Natural Match features.  
• **Sonnet 4**       — Uses the Code-Map to tell Claude *exact* SwiftUI files & line ranges.  
• **Claude Code**    — Accepts one briefing; returns unified git diff for iOS implementation only.  
*(All git add/commit/push steps are done manually by the human.)*

## Daily Loop  
1. Human sets TASK-id → `in-dev` in `backlog.md`.  
2. Human → Gemini:  "prep TASK-id for Claude ≤10k". Briefing must include:  
   • The specific task row from backlog.md  
   • Its parent ticket row (TKT-XX)  
   • **Only the Code-Map nodes that match** the SwiftUI/Swift files needed  
   • ≤10 relevant code snippets (≤300 lines each) from the iOS codebase  
   • Relevant context from `prd.md` and `architecture.md` if needed  
3. Human pastes briefing:  
   `claude "Implement TASK-id per Natural Match context. iOS Swift/SwiftUI diff only."`  
4. Human applies diff, tests on iOS simulator, commits, marks task `done`.

## Guard-rail  
Until step 2, LLMs must ignore any file **outside `/ai_ctx/`**.

## Project-Specific Context

### Core Tech Stack
- **iOS 18+** with SwiftUI framework
- **Supabase** backend (Auth, Database, Storage, Realtime)
- **GPT-4o + Whisper** for AI-powered features
- **CoreLocation** for proximity-based matching

### Key Features to Implement
- **Birdie AI Assistant** - Voice-first onboarding with OpenAI advanced voice mode
- **¼-Mile Match Reveals** - Location-based simultaneous profile discovery  
- **3-Second Intro Videos** - Quick video introductions with auto-deletion
- **Privacy-First Design** - 4-decimal GPS hashing, 24h data retention
- **3-Match Cap System** - Quality over quantity matching

### Development Priorities
1. **Voice-First Birdie Chat** (TKT-01) - Currently in-dev
2. **GPT-4o Personality System** (TKT-02) - 250+ tags, bio generation
3. **Location & Proximity Engine** (TKT-04) - CoreLocation + privacy
4. **Match Reveal System** (TKT-05) - Simultaneous profile discovery

### File Structure Context
```
NaturalMatch/
├── App/                    # App entry point & lifecycle
├── Core/                   # Models, Services, Utilities
├── Features/               # Feature modules (Onboarding, BirdieChat, etc.)
├── AI/                     # GPT, Voice, Matching algorithms
├── Location/               # CoreLocation & proximity services
├── Backend/                # Supabase integration
├── UI/                     # Reusable SwiftUI components
└── Resources/              # Assets, configs, privacy policies
```

### Quality Gates
- ✅ Builds without errors in Xcode
- ✅ Follows SwiftUI + iOS 18 patterns  
- ✅ Respects privacy requirements (location hashing, auto-deletion)
- ✅ Integrates with Supabase backend correctly
- ✅ Voice features work with OpenAI APIs
- ✅ UI matches voice-first, minimal design principles

---

*Charter Version: 1.0*  
*Project: Natural Match iOS*  
*Last Updated: Aligned with detailed backlog and architecture* 