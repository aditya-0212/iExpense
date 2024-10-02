//
//  AddNewView.swift
//  iExpense
//
//  Created by APPLE on 13/05/24.
//

import SwiftUI

struct AddNewView: View {
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    @Environment(\.dismiss) var dismiss
    var expenses : Expenses
    let types = ["Business","Personal"]
    
    var body: some View {
       NavigationStack{
            Form{
                TextField("name",text: $name)
                
                Picker("Type",selection: $type){
                    ForEach(types,id: \.self){
                        Text($0)
                    }
                }
                TextField("Amount",value: $amount,format: .currency(code:Locale.current.currency?.identifier ?? "USD")).keyboardType(.decimalPad)
            }
            .navigationTitle("Add new expense")
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing){
                    Button("Save") {
                        let item = ExpenseItem(name: name, type: type, amount: amount)
                        expenses.items.append(item)
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigation){
                    Button("cancel",role: .cancel) {
                        dismiss()
                    }
                }
                
            }
        }
    }
}

#Preview {
    AddNewView(expenses: Expenses())
}
