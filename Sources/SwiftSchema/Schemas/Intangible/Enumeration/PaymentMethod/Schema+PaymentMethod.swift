//
//  Schema+PaymentMethod.swift
//  SwiftSchema
//
//  Created by Sherlock, James on 06/02/2019.
//

import Foundation

extension Schema {
    
    public var paymentMethodSchema: PaymentMethodSchema? {
        switch self {
        case .paymentMethod(let schema):
            return schema
        default:
            return nil
        }
    }
    
}
