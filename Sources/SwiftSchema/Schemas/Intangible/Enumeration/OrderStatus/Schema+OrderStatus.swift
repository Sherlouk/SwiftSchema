//
//  Schema+OrderStatus.swift
//  SwiftSchema
//
//  Created by Sherlock, James on 06/02/2019.
//

import Foundation

extension Schema {
    
    public var orderStatusSchema: OrderStatusSchema? {
        switch self {
        case .orderStatus(let schema):
            return schema
        default:
            return nil
        }
    }
    
}
