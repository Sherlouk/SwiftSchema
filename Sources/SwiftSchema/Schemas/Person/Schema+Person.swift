//
//  Schema+Person.swift
//  SwiftSchema
//
//  Created by Sherlock, James on 06/02/2019.
//

import Foundation

extension Schema {
    
    public var personSchema: PersonSchema? {
        switch self {
        case .person(let schema):
            return schema
        default:
            return nil
        }
    }
    
}
