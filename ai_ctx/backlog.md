# Development Backlog - Natural Match iOS

## 🎯 Current Sprint Goals
**Sprint 1**: Foundation & Authentication (MVP Phase 1)
- Complete user authentication system
- Basic profile creation workflow
- Photo upload functionality

## 📋 Ticket Status Legend
- 🔥 **High Priority** - Critical for MVP
- ⚡ **Medium Priority** - Important but not blocking
- 💡 **Low Priority** - Future enhancement
- ✅ **Completed** - Done
- 🚧 **In Progress** - Currently being worked on
- 📝 **Ready** - Ready to start

---

## 🚀 Sprint 1: Foundation & Authentication

### ✅ COMPLETED

#### NM-001: Project Setup
- ✅ Create GitHub repository 
- ✅ Set up Xcode project structure
- ✅ Configure SwiftUI app with iOS 16+ support
- ✅ Create welcome screen with pink theme
- ✅ Set up asset catalogs and project configuration

### 📝 READY TO START

#### NM-002: Authentication System 🔥
**Epic**: User can sign up and sign in to the app
**Story Points**: 1 (broken down below)

##### NM-002a: Sign Up Screen UI (1 SP)
- Create SignUpView with SwiftUI
- Form fields: email, password, confirm password
- Validation UI states (error/success)
- Navigation from welcome screen

##### NM-002b: Sign In Screen UI (1 SP)
- Create SignInView with SwiftUI  
- Form fields: email, password
- "Forgot Password" link
- Navigation between sign up/sign in

##### NM-002c: Authentication Service (1 SP)
- Create AuthenticationManager class
- Email/password validation logic
- Basic user session management
- Error handling for auth failures

##### NM-002d: Keychain Integration (1 SP)
- Store user credentials securely
- Auto-login functionality
- Logout capability
- Handle keychain access errors

#### NM-003: Basic Profile Creation 🔥
**Epic**: User can create their dating profile
**Story Points**: 1 (broken down below)

##### NM-003a: Profile Model & Data (1 SP)
- Create User/Profile data models
- Core profile fields (name, age, bio)
- Profile completion validation
- Data persistence setup

##### NM-003b: Profile Creation UI (1 SP)
- Create ProfileCreationView
- Form with basic profile fields
- Progress indicator for completion
- Save/continue navigation flow

##### NM-003c: Profile Photo Upload (1 SP)
- Photo picker integration
- Image compression and validation
- Multiple photo support (up to 6)
- Photo reordering functionality

##### NM-003d: Profile Preview & Edit (1 SP)
- Profile preview screen
- Edit profile capability
- Profile completion percentage
- Save changes functionality

---

## 🎯 Sprint 2: Core Matching System

### 📝 PLANNED

#### NM-004: Personality Assessment ⚡
**Epic**: Users complete personality questionnaire for matching

##### NM-004a: Question Database (1 SP)
- Create personality questions data model
- Implement question categories (values, interests, lifestyle)
- Question randomization logic
- Scoring system foundation

##### NM-004b: Assessment UI Flow (1 SP)
- Multi-step questionnaire interface
- Progress tracking and navigation
- Question types (multiple choice, scale, etc.)
- Save progress functionality

##### NM-004c: Results Processing (1 SP)
- Calculate personality scores
- Generate compatibility metrics
- Store assessment results
- Update user profile with results

#### NM-005: Basic Matching Algorithm ⚡
**Epic**: System can generate compatible matches

##### NM-005a: Compatibility Scoring (1 SP)
- Implement basic compatibility algorithm
- Weight different compatibility factors
- Calculate match percentages
- Minimum compatibility thresholds

##### NM-005b: Match Discovery Interface (1 SP)
- Create MatchesView with card interface
- Swipe gestures for accept/decline
- Match details and reasoning display
- Empty state for no matches

##### NM-005c: Match Management (1 SP)
- Store match decisions (like/pass)
- Mutual match detection
- Match expiration logic
- Match history tracking

---

## 🎯 Sprint 3: Communication

### 📝 PLANNED

#### NM-006: Basic Messaging 💡
**Epic**: Matched users can message each other

##### NM-006a: Chat Data Model (1 SP)
- Message data structure
- Conversation threading
- Message status (sent/delivered/read)
- Media message support planning

##### NM-006b: Chat Interface (1 SP)
- Conversation list view
- Individual chat screen
- Message bubbles and formatting
- Real-time message updates

##### NM-006c: Message Sending (1 SP)
- Text message composition
- Send message functionality
- Delivery confirmations
- Offline message queuing

---

## 🔮 Future Backlog (Not Prioritized)

### NM-007: Advanced Features 💡
- Video chat integration
- Voice messages
- Photo sharing in chat
- Location-based matching
- Date planning tools

### NM-008: Safety & Verification 💡
- Profile verification system
- Report and block functionality
- Content moderation
- Safety tips and resources

### NM-009: Performance & Polish 💡
- App performance optimization
- Advanced animations
- Accessibility improvements
- Analytics integration

---

## 📊 Sprint Metrics

### Sprint 1 Goals
- **Target Velocity**: 8 story points
- **Duration**: 2 weeks
- **Key Milestone**: Functional authentication and basic profile creation

### Definition of Done
- ✅ Feature works on iOS simulator
- ✅ Code follows Swift/SwiftUI best practices
- ✅ Basic error handling implemented
- ✅ UI matches design guidelines
- ✅ Core functionality manually tested

### Sprint Review Criteria
- [ ] New users can sign up successfully
- [ ] Returning users can sign in
- [ ] Users can create and edit their profile
- [ ] Photos can be uploaded and displayed
- [ ] App navigation flows smoothly

---

*Last Updated: Initial creation*
*Next Review: Weekly sprint planning* 