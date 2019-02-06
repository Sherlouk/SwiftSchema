//
//  Schema+Invoice.swift
//  SwiftSchema
//
//  Created by Sherlock, James on 06/02/2019.
//

import Foundation

extension Schema {
    
    public var invoiceSchema: InvoiceSchema? {
        switch self {
        case .invoice(let schema):
            return schema
        default:
            return nil
        }
    }
    
}
