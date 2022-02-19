//
//  ContentView.swift
//  iExpense
//
//  Created by Chris Peloso on 1/29/22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var expenses = Expenses()
    
    @State public var showingAddExpense = false
    
    @State private var currencyCode = Locale.current.currencyCode ?? "USD"
        
    var body: some View {
        
        NavigationView{
            Form{
                Section{
                    List{
                        ForEach(expenses.items){item in
                            if(item.type == "Personal"){
                                HStack{
                                    Text(item.name)
                                        .font(.headline)

                                    Spacer()

                                    Text(item.amount, format: .currency(code: currencyCode))
                                        .foregroundColor(item.amount < 10 ? .green : item.amount < 100 ? .orange : .red)
                                }
                            }
                        }
                        .onDelete(perform: removeItems)
                    }
                }
                
                Section{
                    List{
                        ForEach(expenses.items){item in
                            if(item.type == "Business"){
                                HStack{
                                    Text(item.name)
                                        .font(.headline)
                                    Spacer()
                                    
                                    Text(item.amount, format: .currency(code: currencyCode))
                                        .foregroundColor(item.amount < 10 ? .green : item.amount < 100 ? .orange : .red)
                                }
                            }
                        }
                        .onDelete(perform: removeItems)
                    }
                }
            }
            .navigationTitle("iExpense")
            .toolbar{
                Button{
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddExpense){
                AddView(expenses: expenses)
            }
        }
    }
    
    func removeItems(at offsets: IndexSet){
        expenses.items.remove(atOffsets: offsets)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
