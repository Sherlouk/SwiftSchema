//
//  Schema.swift
//  SwiftSchema
//
//  Created by Sherlock, James on 06/02/2019.
//

import Foundation

public indirect enum Schema: Decodable {
    
    /// Testing switch which fails decoding if a present value is invalid
    static internal var inStrictMode: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case type = "@type"
    }
    
    public enum Error: LocalizedError {
        case unknownType(String)
        case multipleErrors(Swift.Error, Swift.Error)
        
        var localizedDescription: String {
            switch self {
            case .unknownType(let type):
                return "Type of \"\(type)\" was provided, but this is not currently supported."
            case .multipleErrors(let errorOne, let errorTwo):
                return [
                    String(describing: errorOne),
                    String(describing: errorTwo)
                ].joined(separator: "\n\n")
            }
        }
    }
    
    case orderItem(OrderItemSchema)
    case invoice(InvoiceSchema)
    case orderStatus(OrderStatusSchema)
    case paymentMethod(PaymentMethodSchema)
    case parcelDelivery(ParcelDeliverySchema)
    case postalAddress(PostalAddressSchema)
    case offer(OfferSchema)
    case order(OrderSchema)
    case organization(OrganizationSchema)
    case person(PersonSchema)
    case product(ProductSchema)
    case array([Schema])
    
    public init(from decoder: Decoder) throws {
        do {
            // Step 1: Try to parse the Schema as a single object
            
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let type = try container.decode(String.self, forKey: .type)
            
            switch type {
            case OrderItemSchema.type: self = .orderItem(try OrderItemSchema(from: decoder))
            case InvoiceSchema.type: self = .invoice(try InvoiceSchema(from: decoder))
            case OrderStatusSchema.type: self = .orderStatus(try OrderStatusSchema(from: decoder))
            case PaymentMethodSchema.type: self = .paymentMethod(try PaymentMethodSchema(from: decoder))
            case ParcelDeliverySchema.type: self = .parcelDelivery(try ParcelDeliverySchema(from: decoder))
            case PostalAddressSchema.type: self = .postalAddress(try PostalAddressSchema(from: decoder))
            case OfferSchema.type: self = .offer(try OfferSchema(from: decoder))
            case OrderSchema.type: self = .order(try OrderSchema(from: decoder))
            case OrganizationSchema.type: self = .organization(try OrganizationSchema(from: decoder))
            case PersonSchema.type: self = .person(try PersonSchema(from: decoder))
            case ProductSchema.type: self = .product(try ProductSchema(from: decoder))
            default: throw Error.unknownType(type)
            }
        
        } catch DecodingError.typeMismatch(let type, let context) where context.debugDescription.contains("found an array") {
            
            let originalError = DecodingError.typeMismatch(type, context)
            
            do {
                // Step 2: Try to parse this as an array of Schemas
                
                var container = try decoder.unkeyedContainer()
                var builder = [Schema]()
                
                while container.isAtEnd == false {
                    builder.append(try container.decode(Schema.self))
                }
                
                self = .array(builder)
                
            } catch let secondaryError {
                
                // Step 3: Return both errors for debugging purposes
                throw Error.multipleErrors(originalError, secondaryError)
            }
            
        } catch let originalError {
            throw originalError
        }
    }
    
    /// Description of the type
    public var type: String {
        switch self {
        case .orderItem: return OrderItemSchema.type
        case .invoice: return InvoiceSchema.type
        case .orderStatus: return OrderStatusSchema.type
        case .paymentMethod: return PaymentMethodSchema.type
        case .parcelDelivery: return ParcelDeliverySchema.type
        case .postalAddress: return PostalAddressSchema.type
        case .offer: return OfferSchema.type
        case .order: return OrderSchema.type
        case .organization: return OrganizationSchema.type
        case .person: return PersonSchema.type
        case .product: return ProductSchema.type
        case .array(let items):
            guard let type = items.first?.type else {
                return "Array(Empty)"
            }
            
            return "Array(\(type))"
        }
    }
    
}


extension Schema {
    
    public var array: [Schema]? {
        switch self {
        case .array(let contents):
            return contents
        default:
            return nil
        }
    }
    
}

