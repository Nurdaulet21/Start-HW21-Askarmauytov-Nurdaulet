//
//  Model.swift
//  hw21
//
//  Created by Нурдаулет on 17.11.2023.
//

import Foundation

struct CardResponse: Decodable {
    public var cards: [CardInfo]
}

struct CardInfo: Decodable {
    public var name: String?
    public var manaCost: String?
    public var type: String?
    public var setName: String?
    public var text: String?
}
