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
    
    @State private var currencySymbol = Locale.current.currencyCode ?? "USD"
        
    var body: some View {
        NavigationView{
            List{
                ForEach(expenses.items){item in
                    HStack{
                        VStack(alignment: .leading){
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        
                        Spacer()
                        
                        VStack{
                            Text(item.amount, format: .currency(code: currencySymbol))
                                .foregroundColor(item.amount < 10 ? .green : item.amount < 100 ? .orange : .red)
                        }
                    }
                }
                .onDelete(perform: removeItems)
            }    
            .navigationTitle("iExpense")
            .toolbar{
                Button{
                    print(currencySymbol)
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
