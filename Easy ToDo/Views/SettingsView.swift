import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var searchSettings = ""
    @State private var sendNotify = false
    @State private var choosedLang = ""
    @State private var isDarkmodeOn = false
    @State private var iCloudSynIsEnable = false
    @State private var showingTermsPrivacy = false
    
    var body: some View {
        NavigationStack{
            Form {
                Section("general settings") {
                    Picker("App language", selection: $choosedLang) {
                        Text("English 🇬🇧")
                        Text("Russian 🇷🇺")
                    }
                    Toggle("iCloud synchronization", isOn: $iCloudSynIsEnable)
                }
                Section("notifications") {
                    Toggle("Notifications", isOn: $sendNotify)
                }
                Section("visual design") {
                    Toggle("Dark mode", isOn: $isDarkmodeOn)
                }
            }
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        dismiss()
                    }, label: {
                        Image(systemName: "chevron.left")
                        Text("Tasks")
                    })
                }
            }
        }
        .searchable(text: $searchSettings)
    }
}

#Preview {
    SettingsView()
}
