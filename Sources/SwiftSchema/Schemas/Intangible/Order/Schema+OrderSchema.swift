//
//  Schema+OrderSchema.swift
//  SwiftSchema
//
//  Created by Sherlock, James on 06/02/2019.
//

import Foundation

extension Schema {
    
    public var orderSchema: OrderSchema? {
        switch self {
        case .order(let schema):
            return schema
        default:
            return nil
        }
    }
    
}
