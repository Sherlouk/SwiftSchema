//
//  BoolDataType.swift
//  SwiftSchemaTests
//
//  Created by Sherlock, James on 06/02/2019.
//

import Foundation

public struct BoolDataType: Decodable {
    
    enum Error: Swift.Error {
        case unknownValue
    }
    
    public var value: Bool
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        if let bool = try? container.decode(Bool.self) {
            value = bool
        } else if let string = try? container.decode(String.self) {
            value = string == "true" || string == "yes"
        } else {
            throw Error.unknownValue
        }
    }
    
}
