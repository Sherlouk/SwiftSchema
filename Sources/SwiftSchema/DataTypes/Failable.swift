//
//  Failable.swift
//  SwiftSchema
//
//  Created by Sherlock, James on 06/02/2019.
//

import Foundation

public struct Failable<Contents: Decodable>: Decodable {
    
    public let contents: Contents?
    
    public init(from decoder: Decoder) throws {
        do {
            contents = try Contents(from: decoder)
        } catch {
            if Schema.inStrictMode {
                throw error
            } else {
                contents = nil
            }
        }
    }
    
}
