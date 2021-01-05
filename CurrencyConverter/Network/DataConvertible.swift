//
//  DataConvertible.swift
//  Infra
//
//  Created by Sateesh on 5/22/19.
//  Copyright © 2019 dewa. All rights reserved.
//

import Foundation


protocol DataConvertible {
    /**
     Convert data into an instance of yourself. Throw an error if this fails.
     */
    static func convert(from data: Data?) throws -> Self
}


protocol RequiredDataConvertible: DataConvertible {
    /**
     Convert data into an instance of yourself. Throw an error if this fails.
     */
    static func convert(from data: Data) throws -> Self
}


struct DataConversionError: Error {
    let message: String
}


extension RequiredDataConvertible {
    static func convert(from data: Data?) throws -> Self {
        if let data = data {
            return try convert(from: data)
        } else {
            throw DataConversionError(message: "Failed to get data from the server.")
        }
    }
}


extension Data: RequiredDataConvertible {
    static func convert(from data: Data) throws -> Data {
        return data
    }
}


extension Optional: DataConvertible where Wrapped == Data {
    static func convert(from data: Data?) throws -> Data? {
        return data
    }
}

extension String: RequiredDataConvertible {
    static func convert(from data: Data) throws -> String {
        if let result = String(data: data, encoding: .utf8) {
            return result
        } else {
            throw DataConversionError(message: "Failed to parse data into a utf8 string.")
        }
    }
}

/**
 Dictionary are data convertible.
 */
extension Dictionary: DataConvertible where Key: Any, Value:Any {
    static func convert(from data: Data?) throws -> Dictionary<Key, Value> {
        
        guard let dataResponse = data else {
            throw DataConversionError(message: "Failed to parse data into a utf8 string.")
        }
        do{
            //here dataResponse received from a network request
            let jsonResponse = try JSONSerialization.jsonObject(with:
                dataResponse, options: [])
            print(jsonResponse) //Response result
            return jsonResponse as! Dictionary<Key, Value>

        } catch let parsingError {
            print("Error", parsingError)
            throw DataConversionError(message: "Failed to parse data into a utf8 string.")
        }
        
    }
}

//extension Dictionary: RequiredDataConvertible where Key: NSObject, Value:AnyObject {
//    static func convert(from data: Data) throws -> String {
//        if let result = String(data: data, encoding: .utf8) {
//            return result
//        } else {
//            throw DataConversionError(message: "Failed to parse data into a utf8 string.")
//        }
//    }
//}


struct Empty: DataConvertible {
    static func convert(from data: Data?) throws -> Empty {
        return Empty()
    }
}


struct DecodableConvertible<T: Decodable>: RequiredDataConvertible {
    let model: T

    init(_ model: T) {
        self.model = model
    }

    static func convert(from data: Data) throws -> DecodableConvertible<T> {
        let decoder = JSONDecoder()
        let model = try decoder.decode(T.self, from: data)
        return DecodableConvertible(model)
    }
}
