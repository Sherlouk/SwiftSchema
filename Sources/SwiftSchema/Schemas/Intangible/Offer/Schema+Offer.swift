//
//  Schema+Offer.swift
//  SwiftSchema
//
//  Created by Sherlock, James on 06/02/2019.
//

import Foundation

extension Schema {
    
    public var offerSchema: OfferSchema? {
        switch self {
        case .offer(let schema):
            return schema
        default:
            return nil
        }
    }
    
}
