//
//  DateTime.swift
//  SwiftSchema
//
//  Created by Sherlock, James on 06/02/2019.
//

import Foundation

public struct DateTime: Decodable {
    
    static var formatter = Formatter()
    
    enum Error: Swift.Error {
        case invalidDateFormat
    }
    
    public var date: Date
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        
        guard let date = DateTime.formatter.date(string: rawValue) else {
            throw Error.invalidDateFormat
        }
        
        self.date = date
    }
    
}

// Credit to 'onmyway133' at https://github.com/onmyway133/ISO8601
struct Formatter {
    
    // MARK: - DateFormatter
    
    public var stringToDateFormatter: DateFormatter = {
        let formatter = Foundation.DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyyMMdd HHmmssZ"
        
        return formatter
    }()
    
    public var stringToDateMillisecondsFormatter: DateFormatter = {
        let formatter = Foundation.DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyyMMdd HHmmss.SSSZ"
        
        return formatter
    }()
    
    public var dateToStringFormatter: DateFormatter = {
        let formatter = Foundation.DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        return formatter
    }()
    
    /**
     Parse an ISO8601 string to Date
     
     - parameter string: The string to parse
     
     - returns: A date representation of string formatted using ISO8601, nil if fails
     */
    func date(string: String) -> Date? {
        var basicString = string
        
        if let regex = try? NSRegularExpression(pattern: "[0-9]{4}-[0-9]{2}-[0-9]{2}", options: []),
            let result = regex.firstMatch(in: string, options: .anchored, range: NSMakeRange(0, string.count)) {
            basicString = (basicString as NSString).replacingOccurrences(of: "-", with: "", options: [], range: result.range)
        }
        
        basicString = basicString
            .replacingOccurrences(of: ":", with: "")
            .replacingOccurrences(of: "GMT", with: "")
            .replacingOccurrences(of: "T", with: " ")
            .replacingOccurrences(of: ",", with: ".")
        
        return stringToDateFormatter.date(from: basicString)
            ?? stringToDateMillisecondsFormatter.date(from: basicString)
    }
}
