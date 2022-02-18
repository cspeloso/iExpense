//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Chris Peloso on 2/17/22.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

