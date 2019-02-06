//
//  PaymentMethodSchema.swift
//  SwiftSchema
//
//  Created by Sherlock, James on 06/02/2019.
//

import Foundation

public enum PaymentMethodSchema: Decodable {
    
    /// https://schema.org/PaymentMethod
    static var type: String {
        return "PaymentMethod"
    }
    
    enum CodingKeys: String, CodingKey {
        case name
    }
    
    enum Error: LocalizedError {
        case invalidParameter
        
        var localizedDescription: String {
            switch self {
            case .invalidParameter:
                return "Could not find status member in value."
            }
        }
    }
    
    case rawValue(String)
    
    public init(from decoder: Decoder) throws {
        
        func decode(string: String) throws -> PaymentMethodSchema {
            let characterSet = CharacterSet(charactersIn: "/#")
            
            guard let methodRawValue = string.components(separatedBy: characterSet).last else {
                throw Error.invalidParameter
            }
            
            return .rawValue(methodRawValue)
        }
        
        do {
            let container = try decoder.singleValueContainer()
            let rawValue = try container.decode(String.self)
            self = try decode(string: rawValue)
        } catch {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let rawValue = try container.decode(String.self, forKey: .name)
            self = try decode(string: rawValue)
        }
    }
    
}
