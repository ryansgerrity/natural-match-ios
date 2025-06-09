# 🗂️ Backlog (ONE story point per task)

## Tickets
| Ticket | Status  | Title                                  | Type | Tags        |
|--------|---------|----------------------------------------|------|-------------|
| TKT-01 | in-dev  | Birdie Voice-First Onboarding         | feat | ai, voice   |
| TKT-02 | backlog | GPT-4o Personality Tagging System      | feat | ai, gpt     |
| TKT-03 | backlog | 3-Second Intro Video Recording         | feat | media       |
| TKT-04 | backlog | Location-Based Proximity Detection     | feat | location    |
| TKT-05 | backlog | ¼-Mile Simultaneous Match Reveal       | feat | matching    |
| TKT-06 | backlog | Supabase Backend Integration           | feat | backend     |
| TKT-07 | backlog | Privacy-First Location Hashing         | feat | privacy     |
| TKT-08 | backlog | Daily Hint Generation System           | feat | ai, hints   |
| TKT-09 | backlog | Mutual Meet Coordination Flow          | feat | meeting     |
| TKT-10 | backlog | Match Cap Management (3 active)        | feat | matching    |
| TKT-11 | backlog | Voice Processing (Whisper ASR + TTS)   | feat | voice       |
| TKT-12 | backlog | Auto-Deletion Privacy Compliance       | feat | privacy     |

## Tasks
| Task     | Ticket | Status  | Title                               | Acceptance Criteria                                    |
|----------|--------|---------|------------------------------------|-------------------------------------------------------|
| TASK-011 | TKT-01 | done    | Create BirdieChatView UI           | • Full-screen voice interface • Floating controls     |
| TASK-012 | TKT-01 | in-dev  | Birdie avatar with speaking states  | • Idle/listening/speaking animations • Pulse effects  |
| TASK-013 | TKT-01 | backlog | Mic toggle button functionality    | • Mute/unmute with visual feedback • Haptic response  |
| TASK-014 | TKT-01 | backlog | End conversation button            | • Graceful exit • Save progress • Resume capability   |
| TASK-015 | TKT-01 | backlog | Continuous voice recording          | • Stream audio chunks • No length limits             |
| TASK-016 | TKT-01 | backlog | Real-time voice activity detection | • VAD silence detection • Auto mic management        |
| TASK-017 | TKT-01 | backlog | Conversation state management      | • Pause/resume • Background handling • Session restore|
| TASK-018 | TKT-01 | backlog | Onboarding progress tracking       | • Question completion % • Topic coverage metrics     |
| TASK-019 | TKT-01 | backlog | Response logging & persistence     | • Store all Q&A pairs • Timestamp tracking          |
| TASK-01A | TKT-01 | backlog | Interruption handling              | • User can interrupt Birdie • Graceful conversation  |
| TASK-01B | TKT-01 | backlog | Audio feedback & confirmation      | • "Got it" responses • Clarification requests        |
| TASK-01C | TKT-01 | backlog | Conversation flow branching        | • Dynamic follow-up questions • Context awareness    |
| TASK-021 | TKT-02 | backlog | GPT-4o API client setup            | • API key management • Rate limiting • Error retry   |
| TASK-022 | TKT-02 | backlog | Conversation analysis pipeline     | • Extract personality insights • Topic categorization |
| TASK-023 | TKT-02 | backlog | Generate 250+ personality tags     | • JSONB storage • Tag confidence scores              |
| TASK-024 | TKT-02 | backlog | Personality tag validation         | • Remove duplicates • Quality scoring • Min threshold|
| TASK-025 | TKT-02 | backlog | Bio generation from tags           | • 40-60 words • Natural language • Fun facts         |
| TASK-026 | TKT-02 | backlog | Bio quality & safety checks        | • Content moderation • Appropriateness scoring      |
| TASK-027 | TKT-02 | backlog | Compatibility scoring engine       | • Cosine similarity • Tag weighting • Score caching |
| TASK-028 | TKT-02 | backlog | Personality insights UI            | • Show tags to user • Edit/confirm capability        |
| TASK-031 | TKT-03 | backlog | Video recording permission flow    | • Camera access • Permission explanations            |
| TASK-032 | TKT-03 | backlog | 3-second video capture             | • Countdown timer • Auto-stop • Preview before save |
| TASK-033 | TKT-03 | backlog | Video compression & optimization   | • <2MB target • H.264 encoding • Quality presets    |
| TASK-034 | TKT-03 | backlog | Video upload to Supabase Storage   | • Progress indicators • Retry on failure • Checksums|
| TASK-035 | TKT-03 | backlog | Video player component             | • Smooth playback • Tap to replay • Loading states  |
| TASK-036 | TKT-03 | backlog | Video recording retry flow         | • Re-record option • Multiple attempts • Quality tips|
| TASK-037 | TKT-03 | backlog | Video thumbnail generation         | • First frame capture • Fallback placeholder        |
| TASK-041 | TKT-04 | backlog | Location permissions UI flow       | • Permission explanations • Settings deep-link       |
| TASK-042 | TKT-04 | backlog | CoreLocation manager setup         | • Background/foreground modes • Power optimization   |
| TASK-043 | TKT-04 | backlog | Proximity detection algorithm      | • ¼-mile threshold (400m) • Haversine calculation    |
| TASK-044 | TKT-04 | backlog | Location update batching           | • 30-second intervals • Significant change only      |
| TASK-045 | TKT-04 | backlog | GPS accuracy validation            | • Min accuracy 100m • Quality filtering              |
| TASK-046 | TKT-04 | backlog | Location privacy hashing           | • 4-decimal precision • SHA256 hashing               |
| TASK-047 | TKT-04 | backlog | Location data cleanup service      | • 24h auto-deletion • Background cleanup tasks       |
| TASK-048 | TKT-04 | backlog | Proximity event logging            | • Track detection events • Analytics integration     |
| TASK-051 | TKT-05 | backlog | Proximity threshold monitoring     | • Real-time distance calculation • Multi-user sync   |
| TASK-052 | TKT-05 | backlog | Simultaneous reveal coordination   | • Both users triggered • Race condition handling     |
| TASK-053 | TKT-05 | backlog | Match reveal UI animation          | • Card flip effect • Progressive disclosure          |
| TASK-054 | TKT-05 | backlog | Bio & video display layout         | • Responsive design • Accessibility support          |
| TASK-055 | TKT-05 | backlog | Meet button interaction            | • Mutual interest tracking • Response timeouts       |
| TASK-056 | TKT-05 | backlog | Reveal notification system         | • Push notifications • In-app alerts                 |
| TASK-057 | TKT-05 | backlog | Distance indicator component       | • Real-time updates • Visual proximity feedback      |
| TASK-061 | TKT-06 | backlog | Supabase client configuration     | • Environment setup • API keys management            |
| TASK-062 | TKT-06 | backlog | Authentication service integration | • Sign up/in flows • Token management                |
| TASK-063 | TKT-06 | backlog | Database schema & migrations       | • User tables • Personality data • Match tracking    |
| TASK-064 | TKT-06 | backlog | Storage bucket configuration       | • Video/photo policies • Auto-deletion rules         |
| TASK-065 | TKT-06 | backlog | Real-time subscriptions setup     | • Birdie chat • Proximity events • Match updates     |
| TASK-066 | TKT-06 | backlog | Error handling & retry logic       | • Network failures • Exponential backoff             |
| TASK-067 | TKT-06 | backlog | Offline data synchronization      | • Local caching • Sync on reconnect                  |
| TASK-071 | TKT-07 | backlog | Privacy-compliant location hashing | • 4-decimal GPS precision • SHA256 + salt            |
| TASK-072 | TKT-07 | backlog | Automated data retention policies  | • Configurable deletion rules • Audit logging        |
| TASK-073 | TKT-07 | backlog | 24h GPS data cleanup scheduler     | • Background task • Batch deletion • Error recovery  |
| TASK-074 | TKT-07 | backlog | GDPR/CCPA data export functionality| • JSON export format • 30-day SLA • Complete dataset|
| TASK-075 | TKT-07 | backlog | User data deletion on request      | • Account deletion • Cascading cleanup • Verification|
| TASK-076 | TKT-07 | backlog | Privacy consent tracking           | • Consent timestamps • Granular permissions          |
| TASK-077 | TKT-07 | backlog | Data anonymization service         | • Remove PII • Statistical aggregation               |
| TASK-081 | TKT-08 | backlog | Location routine pattern analysis  | • ML clustering • Temporal patterns • 60% threshold  |
| TASK-082 | TKT-08 | backlog | Venue database integration         | • POI lookup • Distance calculations • Ratings       |
| TASK-083 | TKT-08 | backlog | Daily hint content generation      | • GPT venue descriptions • Personalized suggestions  |
| TASK-084 | TKT-08 | backlog | Hint delivery scheduling           | • Max 1/day • Optimal timing • User preferences      |
| TASK-085 | TKT-08 | backlog | Hint effectiveness tracking        | • Click-through rates • Meetup correlation           |
| TASK-086 | TKT-08 | backlog | Birdie chat hint integration       | • Inline hint cards • Tap for map • History view     |
| TASK-087 | TKT-08 | backlog | Anti-spam hint filtering           | • Quality scoring • Duplicate prevention             |
| TASK-091 | TKT-09 | backlog | Mutual interest detection system   | • Both users "Yes" • Race condition handling         |
| TASK-092 | TKT-09 | backlog | Meetup location suggestions        | • Midpoint calculation • Safety considerations       |
| TASK-093 | TKT-09 | backlog | Birdie coordination chat flow      | • Dynamic responses • Time suggestions               |
| TASK-094 | TKT-09 | backlog | Map integration for meetups        | • Apple Maps • Walking directions • ETA estimates    |
| TASK-095 | TKT-09 | backlog | Meetup confirmation & tracking     | • Status updates • Arrival notifications             |
| TASK-096 | TKT-09 | backlog | Safety features for meetups        | • Public venue suggestions • Emergency contacts      |
| TASK-097 | TKT-09 | backlog | Post-meetup feedback collection    | • Rating system • Improvement suggestions            |
| TASK-101 | TKT-10 | backlog | Match counter & enforcement        | • Real-time tracking • Prevent overflow              |
| TASK-102 | TKT-10 | backlog | Archive selection interface        | • Match cards • Archive reasons • Confirmation       |
| TASK-103 | TKT-10 | backlog | Match cap notification system      | • Full capacity alerts • Archive suggestions         |
| TASK-104 | TKT-10 | backlog | Archived match management          | • View archived • Restore options • Permanent delete |
| TASK-105 | TKT-10 | backlog | Match quality scoring              | • Engagement metrics • Auto-archive suggestions      |
| TASK-106 | TKT-10 | backlog | Dynamic cap adjustment (Phase 2)   | • 2-4 range • User behavior analysis                 |
| TASK-111 | TKT-11 | backlog | OpenAI Whisper API integration     | • Real-time streaming • Language detection           |
| TASK-112 | TKT-11 | backlog | Voice activity detection (VAD)     | • Silence detection • Noise filtering                |
| TASK-113 | TKT-11 | backlog | TTS voice selection & quality      | • Natural voices • Speed controls • Emotion          |
| TASK-114 | TKT-11 | backlog | Audio streaming & buffering        | • Low latency • Smooth playback • Error recovery     |
| TASK-115 | TKT-11 | backlog | Voice data encryption & security   | • End-to-end encryption • Secure deletion            |
| TASK-116 | TKT-11 | backlog | Apple Speech framework fallback    | • Device-only processing • Privacy mode              |
| TASK-117 | TKT-11 | backlog | Voice accessibility features       | • Hearing impaired support • Volume controls         |
| TASK-121 | TKT-12 | backlog | Automated data cleanup scheduler   | • Cron jobs • Batch processing • Error monitoring    |
| TASK-122 | TKT-12 | backlog | Media file lifecycle management    | • Upload tracking • Usage monitoring • Auto-deletion |
| TASK-123 | TKT-12 | backlog | User consent & preference management| • Granular controls • Easy opt-out • Legal compliance|
| TASK-124 | TKT-12 | backlog | Privacy audit logging              | • Deletion events • Access tracking • Compliance reports|
| TASK-125 | TKT-12 | backlog | Data breach response automation    | • Detection systems • User notifications • Compliance|

---

*Last Updated: Initial creation*
*Next Review: Weekly sprint planning* 