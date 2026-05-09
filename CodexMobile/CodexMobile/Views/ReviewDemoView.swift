// FILE: ReviewDemoView.swift
// Purpose: Lightweight offline demo path for TestFlight Beta App Review.
// Layer: View
// Exports: ReviewDemoView

import SwiftUI

struct ReviewDemoView: View {
    let onClose: () -> Void

    @State private var messages: [ReviewDemoMessage] = ReviewDemoMessage.initialMessages
    @State private var isSending = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                demoHeader

                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 14) {
                        ForEach(messages) { message in
                            ReviewDemoMessageBubble(message: message)
                        }
                    }
                    .padding(.horizontal, 18)
                    .padding(.vertical, 18)
                }

                demoComposer
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Dexora Demo")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Done", action: onClose)
                }
            }
        }
    }

    private var demoHeader: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 10) {
                Image("AppLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))

                VStack(alignment: .leading, spacing: 2) {
                    Text("Demo Mac")
                        .font(AppFont.subheadline(weight: .semibold))
                    Text("Connected locally for review")
                        .font(AppFont.caption())
                        .foregroundStyle(.secondary)
                }

                Spacer()

                Text("Demo")
                    .font(AppFont.caption(weight: .semibold))
                    .foregroundStyle(.green)
                    .padding(.horizontal, 9)
                    .padding(.vertical, 5)
                    .background(Color.green.opacity(0.12), in: Capsule())
            }

            Text("This offline mode lets App Review inspect Dexora without pairing to the developer's private Mac. Real users connect by scanning the bridge QR code.")
                .font(AppFont.caption())
                .foregroundStyle(.secondary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(16)
        .background(Color(.systemBackground))
    }

    private var demoComposer: some View {
        VStack(spacing: 10) {
            Button(action: sendDemoMessage) {
                HStack(spacing: 10) {
                    if isSending {
                        ProgressView()
                            .scaleEffect(0.85)
                    } else {
                        Image(systemName: "paperplane.fill")
                    }

                    Text(isSending ? "Sending Demo Message..." : "Send Demo Message")
                        .font(AppFont.body(weight: .semibold))
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .foregroundStyle(Color(.systemBackground))
                .background(Color.primary, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
            }
            .buttonStyle(.plain)
            .disabled(isSending)

            Text("No network, account, payment, or private relay is used in this demo.")
                .font(AppFont.caption2())
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding(16)
        .background(.regularMaterial)
    }

    private func sendDemoMessage() {
        guard !isSending else { return }
        HapticFeedback.shared.triggerImpactFeedback(style: .light)
        isSending = true

        let userMessage = ReviewDemoMessage(
            role: .user,
            text: "Summarize what changed in my project and suggest the next step."
        )
        messages.append(userMessage)

        Task { @MainActor in
            try? await Task.sleep(nanoseconds: 650_000_000)
            messages.append(
                ReviewDemoMessage(
                    role: .assistant,
                    text: "Demo response: Dexora would stream the request to the bridge on your computer, where Codex can inspect the project, run tools, and return results to your phone."
                )
            )
            isSending = false
        }
    }
}

private struct ReviewDemoMessage: Identifiable, Equatable {
    enum Role {
        case user
        case assistant
    }

    let id = UUID()
    let role: Role
    let text: String

    static let initialMessages: [ReviewDemoMessage] = [
        ReviewDemoMessage(
            role: .assistant,
            text: "Dexora is a self-hosted companion for controlling a coding agent running on your own computer."
        ),
        ReviewDemoMessage(
            role: .user,
            text: "Can I use it without a public server?"
        ),
        ReviewDemoMessage(
            role: .assistant,
            text: "Yes. The normal flow pairs this iPhone with your bridge by QR code. The relay only routes encrypted messages after pairing."
        ),
    ]
}

private struct ReviewDemoMessageBubble: View {
    let message: ReviewDemoMessage

    var body: some View {
        HStack {
            if message.role == .user {
                Spacer(minLength: 40)
            }

            Text(message.text)
                .font(AppFont.body())
                .foregroundStyle(message.role == .user ? Color(.systemBackground) : .primary)
                .padding(.horizontal, 14)
                .padding(.vertical, 11)
                .background(
                    bubbleColor,
                    in: RoundedRectangle(cornerRadius: 16, style: .continuous)
                )
                .frame(maxWidth: 320, alignment: message.role == .user ? .trailing : .leading)

            if message.role == .assistant {
                Spacer(minLength: 40)
            }
        }
    }

    private var bubbleColor: Color {
        switch message.role {
        case .user:
            return Color.primary
        case .assistant:
            return Color(.systemBackground)
        }
    }
}

#Preview {
    ReviewDemoView(onClose: {})
}
