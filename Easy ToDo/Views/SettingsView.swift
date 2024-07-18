import SwiftUI

struct SettingsView: View {
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
        }
        .searchable(text: $searchSettings)
    }
}

#Preview {
    SettingsView()
}
