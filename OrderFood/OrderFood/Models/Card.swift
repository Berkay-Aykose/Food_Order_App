//
//  Card.swift
//  OrderFood
//
//  Created by Berkay Veysel Ayköse on 6.05.2025.
//

import Foundation

struct Card: Hashable{
    var name: String = ""
    var number: String = ""
    var cvv: String = ""
    var month: String = ""
    var year: String = ""
    
    var rawCardNumber: String {
        number.replacingOccurrences(of: " ", with: "")
    }
}

enum ActiveField {
    case none
    case number
    case cvv
    case month
    case year
    case name
}
