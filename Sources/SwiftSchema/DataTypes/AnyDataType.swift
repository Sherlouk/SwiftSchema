//
//  AnyDataType.swift
//  SwiftSchema
//
//  Created by Sherlock, James on 06/02/2019.
//

import Foundation

public enum AnySchemaDataType: Decodable {

    enum Error: Swift.Error {
        case unknownType
    }

    case boolean(Bool)
    case dateTime(DateTime)
    case number(Float)
    case text(String)
    case schema(Schema)

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()

        if let bool = try? container.decode(Bool.self) {
            self = .boolean(bool)
        } else if let number = try? container.decode(Float.self) {
            self = .number(number)
        } else if let schema = try? container.decode(Schema.self) {
            self = .schema(schema)
        } else if let dateTime = try? container.decode(DateTime.self) {
            self = .dateTime(dateTime)
        } else if let text = try? container.decode(String.self) {
            self = .text(text)
        } else {
            throw Error.unknownType
        }
    }

}

extension AnySchemaDataType {

    var bool: Bool? {
        switch self {
        case .boolean(let bool):
            return bool
        default:
            return nil
        }
    }
    
    var text: String? {
        switch self {
        case .text(let text):
            return text
        default:
            return nil
        }
    }
    
}
