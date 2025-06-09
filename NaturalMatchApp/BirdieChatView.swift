import SwiftUI

struct BirdieChatView: View {
    @State private var isListening = false
    @State private var isBirdieSpeaking = false
    @State private var isMicMuted = false
    @State private var conversationProgress: Double = 0.0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Background - Voice-first dark theme
                Color.black
                    .ignoresSafeArea()
                
                // Main Content Area
                VStack(spacing: 0) {
                    // Top Area - Progress and Controls
                    topControlsArea
                        .padding(.top, geometry.safeAreaInsets.top)
                    
                    Spacer()
                    
                    // Center - Birdie Avatar
                    birdieAvatarArea
                    
                    Spacer()
                    
                    // Bottom - Voice Controls
                    bottomVoiceControls
                        .padding(.bottom, geometry.safeAreaInsets.bottom + 20)
                }
            }
        }
        .navigationBarHidden(true)
    }
    
    // MARK: - Top Controls Area
    private var topControlsArea: some View {
        VStack(spacing: 16) {
            // Progress Bar
            HStack {
                Text("Onboarding Progress")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Spacer()
                Text("\(Int(conversationProgress * 100))%")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal, 24)
            
            ProgressView(value: conversationProgress)
                .progressViewStyle(LinearProgressViewStyle(tint: .blue))
                .padding(.horizontal, 24)
            
            // End Conversation Button (Floating)
            HStack {
                Spacer()
                Button(action: endConversation) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title2)
                        .foregroundColor(.red)
                        .background(Color.black.opacity(0.8))
                        .clipShape(Circle())
                }
                .padding(.trailing, 24)
            }
        }
    }
    
    // MARK: - Birdie Avatar Area
    private var birdieAvatarArea: some View {
        VStack(spacing: 24) {
            // Birdie Avatar with Animation States
            ZStack {
                // Outer pulse ring for speaking
                if isBirdieSpeaking {
                    Circle()
                        .stroke(Color.blue.opacity(0.3), lineWidth: 4)
                        .scaleEffect(1.5)
                        .opacity(0.8)
                        .animation(
                            .easeInOut(duration: 1.0)
                            .repeatForever(autoreverses: true),
                            value: isBirdieSpeaking
                        )
                }
                
                // Main avatar circle
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [.blue, .teal],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 120, height: 120)
                    .overlay(
                        Image(systemName: "bird.fill")
                            .font(.system(size: 40))
                            .foregroundColor(.white)
                    )
                    .scaleEffect(isBirdieSpeaking ? 1.1 : 1.0)
                    .animation(.easeInOut(duration: 0.3), value: isBirdieSpeaking)
            }
            
            // Birdie Status Text
            VStack(spacing: 8) {
                Text("Birdie")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                
                Text(birdieStatusText)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
            }
        }
    }
    
    // MARK: - Bottom Voice Controls
    private var bottomVoiceControls: some View {
        VStack(spacing: 20) {
            // Voice Activity Indicator
            if isListening {
                HStack(spacing: 4) {
                    ForEach(0..<5) { index in
                        RoundedRectangle(cornerRadius: 2)
                            .fill(Color.blue)
                            .frame(width: 4, height: CGFloat.random(in: 10...30))
                            .animation(
                                .easeInOut(duration: 0.5)
                                .repeatForever()
                                .delay(Double(index) * 0.1),
                                value: isListening
                            )
                    }
                }
                .frame(height: 40)
            }
            
            // Main Voice Controls Row
            HStack(spacing: 40) {
                // Mic Mute/Unmute Button
                Button(action: toggleMicMute) {
                    Image(systemName: isMicMuted ? "mic.slash.fill" : "mic.fill")
                        .font(.title2)
                        .foregroundColor(isMicMuted ? .red : .white)
                        .frame(width: 56, height: 56)
                        .background(
                            Circle()
                                .fill(Color.gray.opacity(0.3))
                        )
                }
                .disabled(isBirdieSpeaking)
                
                // Main Voice Button (Listening State)
                Button(action: toggleListening) {
                    Image(systemName: isListening ? "stop.circle.fill" : "mic.circle.fill")
                        .font(.system(size: 80))
                        .foregroundColor(isListening ? .red : .blue)
                        .background(
                            Circle()
                                .fill(Color.black.opacity(0.8))
                                .strokeBorder(
                                    isListening ? Color.red : Color.blue,
                                    lineWidth: 2
                                )
                        )
                        .scaleEffect(isListening ? 1.1 : 1.0)
                        .animation(.easeInOut(duration: 0.2), value: isListening)
                }
                .sensoryFeedback(.impact(weight: .medium), trigger: isListening)
                
                // Settings/Info Button
                Button(action: showSettings) {
                    Image(systemName: "info.circle.fill")
                        .font(.title2)
                        .foregroundColor(.white)
                        .frame(width: 56, height: 56)
                        .background(
                            Circle()
                                .fill(Color.gray.opacity(0.3))
                        )
                }
            }
            
            // Helper Text
            Text(helperText)
                .font(.caption)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
        }
        .padding(.horizontal, 24)
    }
    
    // MARK: - Computed Properties
    private var birdieStatusText: String {
        if isBirdieSpeaking {
            return "I'm speaking... (tap to interrupt)"
        } else if isListening {
            return "I'm listening... speak freely"
        } else if isMicMuted {
            return "Microphone is muted"
        } else {
            return "Tap the mic to start our conversation"
        }
    }
    
    private var helperText: String {
        if isBirdieSpeaking {
            return "You can interrupt me anytime by tapping the mic"
        } else if isListening {
            return "Speak naturally - I'll understand when you're done"
        } else if isMicMuted {
            return "Unmute your microphone to continue"
        } else {
            return "I'll guide you through getting to know each other"
        }
    }
    
    // MARK: - Actions
    private func toggleListening() {
        if !isMicMuted {
            isListening.toggle()
            
            // Demo: Simulate Birdie speaking after user stops talking
            if !isListening {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    isBirdieSpeaking = true
                    conversationProgress += 0.1
                    
                    // Simulate end of speaking
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                        isBirdieSpeaking = false
                    }
                }
            }
            // TODO: Implement voice recording start/stop (TASK-015)
        }
    }
    
    private func toggleMicMute() {
        isMicMuted.toggle()
        if isMicMuted {
            isListening = false
        }
        // TODO: Implement mic mute/unmute (TASK-013)
    }
    
    private func endConversation() {
        // TODO: Implement graceful conversation end with save/resume (TASK-014)
        print("End conversation tapped")
    }
    
    private func showSettings() {
        // TODO: Implement settings/info sheet
        print("Settings tapped")
    }
}

// MARK: - Preview
#Preview {
    BirdieChatView()
} 