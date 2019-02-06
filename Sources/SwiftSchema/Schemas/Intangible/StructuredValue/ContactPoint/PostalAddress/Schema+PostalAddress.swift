//
//  Schema+PostalAddress.swift
//  SwiftSchema
//
//  Created by Sherlock, James on 06/02/2019.
//

import Foundation

extension Schema {
    
    public var postalAddressSchema: PostalAddressSchema? {
        switch self {
        case .postalAddress(let schema):
            return schema
        default:
            return nil
        }
    }
    
}
