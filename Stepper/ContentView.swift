//
//  ContentView.swift
//  Stepper
//
//  Created by Ariel Merino on 07/01/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
	@Query(sort: \Item.timestamp, order: .reverse) private var items: [Item]
	@State var step: Int

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(items) { item in
                    NavigationLink {
						VStack{
							Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .long, time: .standard, locale: .current))")
							Stepper(value: .init(get: {
								item.steppercount
							}, set: {
								item.steppercount = $0
							}), step: 10) {
								Text("This it \(item.steppercount)")
							}
						}
                    } label: {
						HStack{
							Text("\(item.steppercount) | \(formateDate(date:item.timestamp))")
//							Text(item.timestamp, format: Date.FormatStyle(date: .long, time: .shortened, locale: Locale(identifier: "es_MX")))
						}
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        } detail: {
            Text("Select an item")
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date(), steppercount: 0)
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

func formateDate(date: Date) -> String {
	let dateFormatter = DateFormatter()
	dateFormatter.dateStyle = .medium
	dateFormatter.timeStyle = .short
	dateFormatter.locale = Locale(identifier: "es_MX")
	return dateFormatter.string(from: date).capitalized(with: Locale(identifier: "es_MX"))
}

#Preview {
    ContentView(step: 0)
        .modelContainer(for: Item.self, inMemory: true)
}
