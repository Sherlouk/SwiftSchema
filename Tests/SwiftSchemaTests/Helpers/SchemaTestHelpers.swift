//
//  SchemaTestHelpers.swift
//  SwiftSchemaTests
//
//  Created by Sherlock, James on 06/02/2019.
//

import XCTest
import SwiftSchema

enum TestError: Swift.Error {
    case invalidJSON
}

func decodeSingle(_ json: String, file: StaticString = #file, line: UInt = #line) throws -> Schema {
    
    let decoder = JSONDecoder()
    
    guard let data = json.data(using: .utf8) else {
        XCTFail("Failed to convert JSON to Data", file: file, line: line)
        throw TestError.invalidJSON
    }
    
    return try decoder.decode(Schema.self, from: data)
    
}
