import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct EasyToDo_widgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack(alignment: .leading) {
            Text("Hello").font(.title2).bold()
            Text("Don't forget about your tasks").font(.subheadline)
        }.foregroundStyle(Color.white)
    }
}

struct EasyToDo_widget: Widget {
    let kind: String = "EasyToDo_widget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                EasyToDo_widgetEntryView(entry: entry)
                    .containerBackground(.black, for: .widget)
            } else {
                EasyToDo_widgetEntryView(entry: entry)
                    .background(Color.black)
            }
        }
        .configurationDisplayName("Easy ToDo")
        .description("This is an Easy ToDo widget.")
    }
}

#Preview(as: .systemSmall) {
    EasyToDo_widget()
} timeline: {
    SimpleEntry(date: .now)
}
