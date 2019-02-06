//
//  OrderSchema.swift
//  SwiftSchema
//
//  Created by Sherlock, James on 06/02/2019.
//

import Foundation

public struct OrderSchema: Decodable {
    
    /// https://schema.org/Order
    static var type: String {
        return "Order"
    }
    
    /// The offer(s) -- e.g., product, quantity and price combinations -- included in the order.
    ///
    /// - Possible Schema Types: Offer.
    public let acceptedOffer: Failable<Schema>?
    
    /// The billing address for the order.
    ///
    /// - Possible Schema Types: PostalAddress.
    public let billingAddress: Failable<Schema>?
    
    /// An entity that arranges for an exchange between a buyer and a seller. In most cases a
    /// broker never acquires or releases ownership of a product or service involved in an exchange.
    /// If it is not clear whether an entity is a broker, seller, or buyer, the latter two terms
    /// are preferred. Supersedes bookingAgent.
    ///
    /// - Possible Schema Types: Organization or Person.
    public let broker: Failable<Schema>?
    
    /// **Superseded!** See `broker`.
    public let bookingAgent: Failable<Schema>?
    
    /// A number that confirms the given order or payment has been received.
    public let confirmationNumber: Failable<String>?
    
    /// Party placing the order or paying the invoice.
    ///
    /// - Possible Schema Types: Organization or Person.
    public let customer: Failable<Schema>?
    
    /// Any discount applied (to an Order).
    ///
    /// - Possible Schema Types: Number or Text.
    public let discount: Failable<AnySchemaDataType>?
    
    /// Code used to redeem a discount.
    public let discountCode: Failable<String>?
    
    /// The currency of the discount.
    ///
    /// Use standard formats: ISO 4217 currency format e.g. "USD";
    /// Ticker symbol for cryptocurrencies e.g. "BTC";
    /// well known names for Local Exchange Tradings Systems (LETS)
    /// and other currency types e.g. "Ithaca HOUR".
    public let discountCurrency: Failable<String>?
    
    /// Was the offer accepted as a gift for someone other than the buyer.
    public let isGift: Failable<BoolDataType>?
    
    /// Date order was placed.
    public let orderDate: Failable<DateTime>?
    
    /// The delivery of the parcel related to this order or order item.
    ///
    /// - Possible Schema Types: ParcelDelivery.
    public let orderDelivery: Failable<Schema>?
    
    /// The identifier of the transaction.
    public let orderNumber: Failable<String>?
    
    /// The current status of the order.
    ///
    /// - Possible Schema Types: OrderStatus.
    public let orderStatus: Failable<OrderStatusSchema>?
    
    /// The item ordered.
    ///
    /// - Possible Schema Types: OrderItem or Product.
    public let orderedItem: Failable<Schema>?
    
    /// The order is being paid as part of the referenced Invoice.
    ///
    /// - Possible Schema Types: Invoice.
    public let partOfInvoice: Failable<Schema>?
    
    /// The date that payment is due. Supersedes paymentDue.
    public let paymentDueDate: Failable<DateTime>?
    
    /// **Superseded!** See `paymentDueDate`.
    public let paymentDue: Failable<DateTime>?
    
    /// The name of the credit card or other method of payment for the order.
    ///
    /// Schema Type: https://schema.org/PaymentMethod
    public let paymentMethod: Failable<PaymentMethodSchema>?
    
    /// An identifier for the method of payment used (e.g. the last 4 digits of the credit card).
    public let paymentMethodId: Failable<String>?
    
    /// The URL for sending a payment.
    public let paymentUrl: Failable<URL>?
    
    /// An entity which offers (sells / leases / lends / loans) the services / goods.
    /// A seller may also be a provider. Supersedes merchant, vendor.
    ///
    /// - Possible Schema Types: Organization or Person.
    public let seller: Failable<Schema>?
    
    /// **Superseded!** See `seller`.
    public let merchant: Failable<Schema>?
    
    /// **Superseded!** See `seller`.
    public let vendor: Failable<Schema>?
    
}

extension OrderSchema {
    
    /// **Compatibility Helper!** Returns broker, or bookingAgent - which ever is first
    /// defined otherwise nil.
    ///
    /// - Possible Schema Types: Organization or Person.
    public var brokerCompatible: Failable<Schema>? {
        return broker ?? bookingAgent
    }
    
    /// **Compatibility Helper!** Returns paymentDueDate, or paymentDue - which ever is first
    /// defined otherwise nil.
    public var paymentDueDateCompatible: Failable<DateTime>? {
        return paymentDueDate ?? paymentDue
    }
    
    /// **Compatibility Helper!** Returns sender, merchant, or vendor - which ever is first
    /// defined otherwise nil.
    ///
    /// - Possible Schema Types: Organization or Person.
    public var sellerCompatible: Failable<Schema>? {
        return seller ?? merchant ?? vendor
    }
    
}
