//
//  ContentView.swift
//  iExpense
//
//  Created by APPLE on 11/05/24.
//

import SwiftUI
struct ExpenseItem: Identifiable, Codable{
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

@Observable
class Expenses {
    var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }

        items = []
    }
}
struct ContentView: View {
    @State private var expenses = Expenses()
    @State private var showingAddExpense = false
    private func textColor(for amount: Double) -> Color {
           if amount < 10 {
               return .green
           } else if amount < 100 {
               return .blue
           } else {
               return .red
           }
       }
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
    var body: some View {
        NavigationStack {
            List {
                    Section("All Business Type"){
                        ForEach(expenses.items) { item in
                        if item.type == "Business"{
                            Text("name:\(item.name) type: \(item.type)  amount:\(item.amount)")
                                .background(item.amount < 10 ? .blue : (item.amount < 100 ? .green : (item.amount < 1000 ? .gray : .black)) )
                                .foregroundColor(textColor(for: item.amount))
                        }
                    }
                        .onDelete(perform: removeItems)
                }
                
                    Section("All Personal type"){
                        ForEach(expenses.items) { item in
                        if item.type == "Personal"{
                            Text("name:\(item.name) type: \(item.type)  amount:\(item.amount)")
                                .background(item.amount < 10 ? .blue : (item.amount < 100 ? .green : (item.amount < 1000 ? .gray : .black)) )
                                .foregroundColor(textColor(for: item.amount))
                        }
                    }
                        .onDelete(perform: removeItems)
                }
            }
            .navigationTitle("iExpense")
            .toolbar{
                NavigationLink("+"){
                    AddNewView(expenses:expenses)
                }
                .font(.title.weight(.bold))
//                Button("Add Expense", systemImage: "plus") {
////                    let expense = ExpenseItem(name: "Test", type: "Personal", amount: 5)
////                    expenses.items.append(expense)
//                    showingAddExpense = true
//                }
            }
//            .sheet(isPresented: $showingAddExpense){
//                //show an add view here
//                AddNewView(expenses:expenses)
//            }
        }
    }
}

#Preview {
    ContentView()
}
