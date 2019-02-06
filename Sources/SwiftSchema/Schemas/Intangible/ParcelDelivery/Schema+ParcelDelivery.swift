//
//  Schema+ParcelDelivery.swift
//  SwiftSchema
//
//  Created by Sherlock, James on 06/02/2019.
//

import Foundation

extension Schema {
    
    public var parcelDeliverySchema: ParcelDeliverySchema? {
        switch self {
        case .parcelDelivery(let schema):
            return schema
        default:
            return nil
        }
    }
    
}
