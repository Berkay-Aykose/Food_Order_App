//
//  Extensions.swift
//  OrderFood
//
//  Created by Berkay Veysel Ayköse on 22.04.2025.
//

import Foundation

extension Encodable{
    func asDictionary() -> [String:Any] {
        guard let data = try? JSONEncoder().encode(self) else {
            return[:]
        }
        
        do{
            let json = try JSONSerialization.jsonObject(with: data) as? [String:Any]
            return json ?? [:]
        }catch{
            return[:]
        }
    }
}
