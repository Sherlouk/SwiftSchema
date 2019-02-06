//
//  OrderStatusSchema.swift
//  SwiftSchema
//
//  Created by Sherlock, James on 06/02/2019.
//

import Foundation

public enum OrderStatusSchema: String, Decodable {
    
    /// https://schema.org/OrderStatus
    static var type: String {
        return "OrderStatus"
    }
    
    enum Error: LocalizedError {
        case invalidParameter
        case statusUnknown(String)
        
        var localizedDescription: String {
            switch self {
            case .invalidParameter:
                return "Could not find status member in value."
                
            case .statusUnknown(let status):
                return "The status \"\(status)\" is currently not being handled."
            }
        }
    }
    
    case orderCancelled         = "OrderCancelled"
    case orderDelivered         = "OrderDelivered"
    case orderInTransit         = "OrderInTransit"
    case orderPaymentDue        = "OrderPaymentDue"
    case orderPickupAvailable   = "OrderPickupAvailable"
    case orderProblem           = "OrderProblem"
    case orderProcessing        = "OrderProcessing"
    case orderReturned          = "OrderReturned"
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        
        guard let statusRawValue = rawValue.components(separatedBy: "/").last else {
            throw Error.invalidParameter
        }
        
        guard let value = OrderStatusSchema(rawValue: statusRawValue) else {
            throw Error.statusUnknown(statusRawValue)
        }
        
        self = value
    }
    
}
