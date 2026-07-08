//
//  SettingTab.swift
//  PlayHub
//
//  Created by Amaya Mahavithane on 2026-07-06.
//



import SwiftUI

struct SettingsTab: View {

    @State private var notifications = false
    @State private var reminder = Date()

    @State private var showAlert = false

    var body: some View {

        NavigationStack {

            Form {

                Toggle("Daily Notifications", isOn: $notifications)
                    .onChange(of: notifications) {

                        if notifications {
                            NotificationService.shared.requestPermission()
                        }

                    }

                DatePicker(
                    "Reminder Time",
                    selection: $reminder,
                    displayedComponents: .hourAndMinute
                )
                .onChange(of: reminder) {

                    let calendar = Calendar.current

                    NotificationService.shared.schedule(
                        hour: calendar.component(.hour, from: reminder),
                        minute: calendar.component(.minute, from: reminder)
                    )

                }

                Button("Reset Statistics", role: .destructive) {
                    showAlert = true
                }

            }
            .confirmationDialog(
                "Delete all statistics?",
                isPresented: $showAlert
            ) {

                Button("Delete", role: .destructive) {

                    GameStorage.shared.reset()

                }

                Button("Cancel", role: .cancel) { }

            }
            .navigationTitle("Settings")

        }

    }
}

#Preview {
    SettingsTab()
}
