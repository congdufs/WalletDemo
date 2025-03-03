//
//  Untitled.swift
//  WalletDemo
//
//  Created by congdufs on 2025/3/2.
//

struct EventItem {
    let id: String
    let imageName: String
    let title: String
}

enum EventType {
    case buy
    case receive
    case connect
}

struct CategoryItem {
    let id: String
    let title: String
    var isSelected: Bool
}

struct Currency: Codable, Identifiable {
    let name: String
    let symbol: String
    let id: Int
    let amount: Double
}

struct NetworkItem {
    let currency: Currency
    var isSelected: Bool
}
