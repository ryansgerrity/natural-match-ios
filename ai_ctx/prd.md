```markdown
# Natural Match – Product Requirements Document (PRD)  
*v 1.0 · 2025-06-09*  

---

## 1 Background & Problem Statement  
Swipe-centric dating apps drive screen fatigue and shallow matches. **Natural Match** removes swiping, hides profiles until real proximity, and relies on a friendly voice assistant—**Birdie**—to guide users toward authentic, in-person introductions.

---

## 2 Personas & Target Users  

| Persona | Key Traits | Needs |
|---------|-----------|-------|
| Busy Ben | 29 y, engineer, time-poor | Effortless, low-noise intros during commute |
| Minimalist Mia | 26 y, digital-wellness advocate | Dating with minimal screen time |
| Introvert Ivy | 30 y, shy designer | AI coaching before meeting someone |
| Safety-First Sam | 27 y, nurse, night shifts | Verified matches, hidden bios |
| Explorer Ezra | 33 y, foodie | Group outings & curated venue tips |

---

## 3 Goals & Success Metrics  

| Goal | Metric | Target |
|------|--------|--------|
| De-clutter experience | Avg. daily app time | ≤ 6 min |
| Encourage IRL meets | % matches meeting within 7 d | ≥ 25 % |
| Ensure conversation depth | Avg. messages per match | ≥ 15 |
| Retain satisfied users | Day-30 retention | ≥ 40 % |
| Ethical revenue | Premium-sub conversion | ≥ 8 % MAU |

---

## 4 Feature List  

### MVP  

| Feature | Key Details |
|---------|-------------|
| **Guided Onboarding** | Birdie conversational intake (10-30 min). Intake ends only after all questions answered. Generates ≥ 250 personality tags. |
| **Profile Assets** | User records 3-sec intro video (“Hey, I’m \<Name\>”) + photo. |
| **Birdie-Authored Bio** | GPT-4o writes **40–60-word** bio using tags; may include two fun facts. Bio is hidden until match reveal. |
| **Potential-Match Hint (≤ 1/day)** | Birdie sends *one* hint only when compatibility is high **and** routines overlap (≥ 60 % chance of crossing paths). Hint names a specific venue + area cue. |
| **¼-Mile Simultaneous Reveal** | At ≈ 400 m both users see bio, photo, video, *Meet?* button. |
| **Mutual Meet Flow** | On mutual *Yes*, Birdie suggests precise spot or walking directions. |
| **Match Cap (3)** | Max three active matches; archive one to accept new. |
| **Redo Intake** | User can rerun Birdie Q&A to refresh tags & bio. |
| **Places & Activities Suggestions v0.5** | Birdie proposes venues/activities in chat (no external event API yet). |
| **Hint History Chat** | All hints logged in Birdie chat thread (reverse chrono). |

### Phase 2  

| Feature | Description |
|---------|-------------|
| **Birdie-Coordinated Micro-Events** | Birdie polls multiple compatible users and coordinates a small outing via group chat—no external service. |
| **UWB/BLE Precision Reveal** | Sub-10 m reveals on U1/U2 iPhones. |
| **Adaptive Match Cap** | Birdie dynamically adjusts cap (2–4) based on engagement. |
| **Travel Mode** | Opt-in wider radius for travelers; lowers hint frequency. |
| **Android App** | Kick-off dev 6 months post-iOS GA; launch within following 6 months. |

---

## 5 User Experience Principles  

1. **Birdie-Led Journey** – Voice-first guidance, minimal UI chrome.  
2. **Hidden Discovery** – Profiles remain hidden until ¼-mile reveal.  
3. **Soft, Specific Hints** – One daily suggestion naming a venue; no spam.  
4. **Consent & Safety** – Opt-in at each stage (location, reveal, meet).  
5. **High-Quality Match Cap (3)** – Encourages depth; discourages ghosting.  
6. **Single Birdie Chat** – Onboarding recap, hints, and event coordination live in one thread.

---

## 6 AI & Assistant Integration  

| Aspect | Implementation |
|--------|----------------|
| Model | OpenAI GPT-4o (temp 0.7) |
| Voice | Whisper ASR + GPT-TTS; Apple Speech fallback |
| Tag Generation | GPT function → ≥ 250 personality tags (JSONB in Supabase) |
| Bio Generator | 40–60-word bio; balanced tone; excludes sensitive data |
| Matching Score | Cosine(tag similarity) × proximity weight × recency decay |
| Hint Trigger | Fires when score ≥ T **and** routine overlap ≥ 60 % ; else no hint |
| Hint Payload | `{venue_name, area_hint, hint_text}` logged to Birdie chat |
| Micro-Event Poller (P2) | GPT orchestrates multi-user scheduling via chat |
| Moderation | All Birdie outputs pass OpenAI moderation API |

---

## 7 Architecture & Technical Stack  

| Layer | Choice | Notes |
|-------|--------|-------|
| **Client** | iOS 17+, SwiftUI | CoreData cache (hints & tags) |
| **Assistant** | GPT-4o API | 3 s latency target |
| **Backend** | Supabase Cloud (Postgres 16) | Auth, DB, Storage, Realtime chat |
| **Storage** | Supabase Storage | Video/photo via signed URLs |
| **Location** | CoreLocation significant-change; NearbyInteraction UWB (P2) |
| **Analytics** | PostHog self-host | Funnels: Onboard → Hint → Reveal → Meet |

*(Component versions & flows are mirrored in `/docs/architecture.md` for dev reference.)*

---

## 8 Privacy, Safety & Compliance  

* **Location**: store 4-dec hashes; delete raw GPS after 24 h.  
* **Media**:  
  * Unmatched reveal media auto-delete after **30 days**.  
  * Archived matches’ media auto-delete after **90 days**.  
* **Chat**: all chats retained indefinitely unless user deletes account.  
* **Voice Data**: purged after ASR (< 60 s).  
* **Age Verification**: Apple Pay token or ID scan.  
* Meets Apple ATT, GDPR, CCPA export/delete within 30 days.

---

## 9 Risks & Mitigations  

| Risk | Mitigation |
|------|------------|
| Onboarding abandonment (10–30 min) | Save/resume checkpoints; Birdie encouragement |
| Hint scarcity | Broaden venue radius after 3 days with no hint |
| GPS drift near ¼-mile | Require two consecutive pings before reveal |
| OpenAI cost spikes | Cache bio/hint generation; explore local fallback model |
| Voice moderation gaps | Manual report flow + daily human review |

---
```
