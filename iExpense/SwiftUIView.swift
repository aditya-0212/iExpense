//
//  SwiftUIView.swift
//  iExpense
//
//  Created by APPLE on 13/05/24.
//

import SwiftUI
import SwiftUI
import Observation

@Observable
class User {
    var firstName = "Bilbo"
    var lastName = "Baggins"
    
}

struct SecondView: View {
    let name: String
    @Environment(\.dismiss) var dismiss
    var body: some View {
        Text("Hello, \(name)!")
        
        Button("Dismiss") {
            dismiss()
        }
    }
}
struct SwiftUIView: View {
    @State private var user = User()
    @State private var showingSheet = false
    @State private var numbers = [Int]()
    @State private var currentNumber = 1
//    @State private var tapCount = 0
//    @State private var tapCount = UserDefaults.standard.integer(forKey: "Tap")
    @AppStorage("tapCount") private var tapCount = 0

    func removeRows(at offsets: IndexSet) {
        numbers.remove(atOffsets: offsets)
    }
    var body: some View {
        NavigationStack{
            
            
            VStack {
                Text("Your name is \(user.firstName) \(user.lastName).")
                
                TextField("First name", text: $user.firstName)
                TextField("Last name", text: $user.lastName)
                
                
                Button("Show Sheet") {
                    showingSheet.toggle()
                }
                .sheet(isPresented: $showingSheet) {
                    SecondView(name: "@twostraws")
                }
                
                List {
                    ForEach(numbers, id: \.self) {
                        Text("Row \($0)")
                    } .onDelete(perform: removeRows)
                }
                Button("Add Number") {
                    numbers.append(currentNumber)
                    currentNumber += 1
                }
                
                Button("Tap count: \(tapCount)") {
                           tapCount += 1
                    UserDefaults.standard.set(tapCount, forKey: "Tap")
                       }
                
                
            }
            .toolbar {
                EditButton()
            }
        }
    
    }
}

#Preview {
    SwiftUIView()
}
