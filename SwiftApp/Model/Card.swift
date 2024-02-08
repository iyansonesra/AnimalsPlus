//
//  Card.swift
//  SwiftApp
//
//  Created by Sonesra, Iyan M on 2/8/24.
//

import SwiftUI

struct Card: Identifiable {
    var id = UUID().uuidString
    var name: String
    var cardNumber: String
    var cardImage: String
}

var cards: [Card] = [

    Card(name: "Giraffe", cardNumber: "6.2", cardImage: "giraffe"),




]
