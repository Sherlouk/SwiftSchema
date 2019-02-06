//
//  Schema+Organization.swift
//  SwiftSchema
//
//  Created by Sherlock, James on 06/02/2019.
//

import Foundation

extension Schema {
    
    public var organizationSchema: OrganizationSchema? {
        switch self {
        case .organization(let schema):
            return schema
        default:
            return nil
        }
    }
    
}
