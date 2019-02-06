//
//  OrderSchemaTests.swift
//  SwiftSchemaTests
//
//  Created by Sherlock, James on 06/02/2019.
//

import XCTest
@testable import SwiftSchema

final class OrderSchemaTests: XCTestCase {

    override func setUp() {
        super.setUp()
        Schema.inStrictMode = true
    }
    
    func testBasicOrder() {
        
        // Sample JSON from https://developers.google.com/gmail/markup/reference/order
        
        let json = """
        {
          "@context": "http://schema.org",
          "@type": "Order",
          "merchant": {
            "@type": "Organization",
            "name": "Amazon.com"
          },
          "orderNumber": "123-4567890-1234567",
          "priceCurrency": "USD",
          "price": "29.99",
          "acceptedOffer": {
            "@type": "Offer",
            "itemOffered": {
              "@type": "Product",
              "name": "Google Chromecast"
            },
            "price": "29.99",
            "priceCurrency": "USD",
            "eligibleQuantity": {
              "@type": "QuantitativeValue",
              "value": "1"
            }
          }
        }
        """
        
        do {
            // 1. Create the Schema model
            let schema = try decodeSingle(json)
            
            // 2. Validate it is of type "Order"
            XCTAssertNotNil(schema.orderSchema)
            
            // 3. Assert the values based on the model JSON
            XCTAssertEqual(schema.orderSchema?.orderNumber?.contents, "123-4567890-1234567")
        } catch {
            XCTFail("Test should not have thrown an error")
            XCTFail(String(describing: error))
        }
        
    }
    
    func testViewOrderAction() {
        
        // Sample JSON from https://developers.google.com/gmail/markup/reference/order
        
        let json = """
        {
          "@context": "http://schema.org",
          "@type": "Order",
          "merchant": {
            "@type": "Organization",
            "name": "Amazon.com"
          },
          "orderNumber": "123-4567890-1234567",
          "orderStatus": "http://schema.org/OrderProcessing",
          "priceCurrency": "USD",
          "price": "29.99",
          "priceSpecification": {
            "@type": "PriceSpecification",
            "validFrom": "2027-12-07T23:30:00-08:00"
          },
          "acceptedOffer": {
            "@type": "Offer",
            "itemOffered": {
              "@type": "Product",
              "name": "Google Chromecast",
              "sku": "B00DR0PDNE",
              "url": "http://www.amazon.com/Google-Chromecast-Streaming-Media-Player/dp/B00DR0PDNE/",
              "image": "http://ecx.images-amazon.com/images/I/811nvG%2BLgML._SY550_.jpg"
            },
            "price": "29.99",
            "priceCurrency": "USD",
            "eligibleQuantity": {
              "@type": "QuantitativeValue",
              "value": "1"
            }
          },
          "url": "https://www.amazon.ca/gp/css/summary/edit.html/orderID=123-4567890-1234567",
          "potentialAction": {
            "@type": "ViewAction",
            "url": "https://www.amazon.ca/gp/css/summary/edit.html/orderID=123-4567890-1234567"
          }
        }
        """
        
        do {
            // 1. Create the Schema model
            let schema = try decodeSingle(json)
            
            // 2. Validate it is of type "Order"
            XCTAssertNotNil(schema.orderSchema)
            
            // 3. Assert the values based on the model JSON
            XCTAssertEqual(schema.orderSchema?.orderNumber?.contents, "123-4567890-1234567")
        } catch {
            XCTFail("Test should not have thrown an error")
            XCTFail(String(describing: error))
        }
        
    }
    
    func testOrderWithBillingInformation() {
        
        // Sample JSON from https://developers.google.com/gmail/markup/reference/order
        
        let json = """
        {
          "@context": "http://schema.org",
          "@type": "Order",
          "merchant": {
            "@type": "Organization",
            "name": "Amazon.com"
          },
          "orderNumber": "123-4567890-1234567",
          "priceCurrency": "USD",
          "price": "539.00",
          "priceSpecification": {
            "@type": "PriceSpecification",
            "validFrom": "2027-12-07T23:30:00-08:00"
          },
          "acceptedOffer": [
            {
              "@type": "Offer",
              "itemOffered": {
                "@type": "Product",
                "name": "Samsung Chromebook",
                "sku": "B009LL9VDG",
                "url": "http://www.amazon.com/Samsung-XE303C12-A01US-Chromebook-Wi-Fi-11-6-Inch/dp/B009LL9VDG/",
                "image": "http://ecx.images-amazon.com/images/I/81H-DO3qX0L._SX522_.jpg"
              },
              "price": "249.99",
              "priceCurrency": "USD",
              "eligibleQuantity": {
                "@type": "QuantitativeValue",
                "value": "2"
              },
              "seller": {
                "@type": "Organization",
                "name": "Samsung Marketplace Store"
              }
            },
            {
              "@type": "Offer",
              "itemOffered": {
                "@type": "Product",
                "name": "Google Chromecast",
                "sku": "B00DR0PDNE",
                "url": "http://www.amazon.com/Google-Chromecast-Streaming-Media-Player/dp/B00DR0PDNE/",
                "image": "http://ecx.images-amazon.com/images/I/811nvG%2BLgML._SY550_.jpg"
              },
              "price": "29.99",
              "priceCurrency": "USD",
              "eligibleQuantity": {
                "@type": "QuantitativeValue",
                "value": "1"
              },
              "seller": {
                "@type": "Organization",
                "name": "Google Store @ Amazon"
              }
            }
          ],
          "url": "https://www.amazon.ca/gp/css/summary/edit.html/orderID=123-4567890-1234567",
          "potentialAction": {
            "@type": "ViewAction",
            "url": "https://www.amazon.ca/gp/css/summary/edit.html/orderID=123-4567890-1234567"
          },
          "orderStatus": "http://schema.org/OrderProcessing",
          "paymentMethod": {
            "@type": "PaymentMethod",
            "name": "http://schema.org/CreditCard"
          },
          "paymentMethodId": "**** **** **** 1234",
          "orderDate": "2027-11-07T23:30:00-08:00",
          "isGift": "false",
          "discount": "0.97",
          "discountCurrency": "USD",
          "customer": {
            "@type": "Person",
            "name": "John Smith"
          },
          "billingAddress": {
            "@type": "PostalAddress",
            "name": "Google",
            "streetAddress": "1600 Amphitheatre Pkwy",
            "addressLocality": "Mountain View",
            "addressRegion": "CA",
            "addressCountry": "USA"
          }
        }
        """
        
        do {
            // 1. Create the Schema model
            let schema = try decodeSingle(json)
            
            // 2. Validate it is of type "Order"
            XCTAssertNotNil(schema.orderSchema)
            
            // 3. Assert the values based on the model JSON
            XCTAssertEqual(schema.orderSchema?.orderNumber?.contents, "123-4567890-1234567")
            XCTAssertEqual(schema.orderSchema?.discount?.contents?.text, "0.97")
        } catch {
            XCTFail("Test should not have thrown an error")
            XCTFail(String(describing: error))
        }
        
    }
    
    func testOrderWithMultipleItems() {
        
        // Sample JSON from https://schema.org/Order - Example Two
        
        let json = """
        {
          "@context": "http://schema.org/",
          "@type": "Order",
          "seller": {
            "@type": "Organization",
            "name": "ACME Supplies"
          },
          "customer": {
            "@type": "Person",
            "name": "Jane Doe"
          },
          "orderedItem": [
            {
              "@type": "OrderItem",
              "orderItemNumber": "abc123",
              "orderQuantity": 1,
              "orderedItem": {
                "@type": "Product",
                "name": "Widget"
              },
              "orderItemStatus": "http://schema.org/OrderDelivered",
              "orderDelivery": {
                "@type": "ParcelDelivery",
                "expectedArrivalFrom": "2015-03-10"
              }
            },
            {
              "@type": "OrderItem",
              "orderItemNumber": "def456",
              "orderQuantity": 3,
              "orderedItem": {
                "@type": "Product",
                "name": "Widget accessories"
              },
              "orderItemStatus": "http://schema.org/OrderInTransit",
              "orderDelivery": {
                "@type": "ParcelDelivery",
                "expectedArrivalFrom": "2015-03-15",
                "expectedArrivalUntil": "2015-03-18"
              }
            }
          ]
        }
        """
        
        do {
            // 1. Create the Schema model
            let schema = try decodeSingle(json)
            
            // 2. Validate it is of type "Order"
            XCTAssertNotNil(schema.orderSchema)
            
            // 3. Assert the values based on the model JSON
            let orderedItems = schema.orderSchema?.orderedItem?.contents?.array
            XCTAssertNotNil(orderedItems)
            XCTAssertNotNil(orderedItems?[0].orderItemSchema)
            XCTAssertNotNil(orderedItems?[1].orderItemSchema)
        } catch {
            XCTFail("Test should not have thrown an error")
            XCTFail(String(describing: error))
        }
        
    }

    static var allTests = [
        ("testBasicOrder", testBasicOrder),
        ("testViewOrderAction", testViewOrderAction),
        ("testOrderWithBillingInformation", testOrderWithBillingInformation),
        ("testOrderWithMultipleItems", testOrderWithMultipleItems)
    ]

}
