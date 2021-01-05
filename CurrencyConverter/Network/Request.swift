//
//  Request.swift
//  Infra
//
//  Created by Sateesh on 3/23/19.
//  Copyright © 2019 dewa. All rights reserved.
//

import Foundation

/**
 A protocol to wrap request objects. This gives us a better API over URLRequest.
 */
protocol Requestable {
    /**
     Generates a URLRequest from the request. This will be run on a background thread so model parsing is allowed.
     */
    func urlRequest() -> URLRequest
}

/**
 A simple request with no post data.
 */
struct Request: Requestable {
    let path: String
    let method: String

    init(path: String, method: String = "GET") {
        self.path = path
        self.method = method
    }

    func urlRequest() -> URLRequest {
        guard let url = URL(string: path) else {
            return URLRequest(url: URL(fileURLWithPath: ""))
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method

        return urlRequest
    }
}

/**
 A request which includes post data. This should be the form of an encodeable model.
 */
struct PostRequest<Model: Encodable>: Requestable {
    let path: String
    let method: String
    let model: Model

    func urlRequest() -> URLRequest {
        guard let url = URL(string: path) else {
            return URLRequest(url: URL(fileURLWithPath: ""))
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method

        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(model)
            urlRequest.httpBody = data
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        } catch let error {
            
        }

        return urlRequest
    }
}

struct FormDataPostRequest: Requestable {
    let path: String
    let method: String
    let params: Dictionary<String,Any>
    
    func urlRequest() -> URLRequest {
        
        let postString = params.compactMap({ (key, value) -> String in
            return "\(key)=\(value)"
        }).joined(separator: "&")
        
        guard let url = URL(string: path) else {
            return URLRequest(url: URL(fileURLWithPath: ""))
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method
        
        
        urlRequest.httpBody = postString.data(using: .utf8)

//        do {
//            let encoder = JSONEncoder()
//            let data = try encoder.encode(model)
//            urlRequest.httpBody = data
//            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        } catch let error {
//            Log.assertFailure("Post request model parsing failed: \(error.localizedDescription)")
//        }
        
        return urlRequest
    }
}

/**
 Making URLRequest also conform to request so it can be used with our stack.
 */
extension URLRequest: Requestable {
    func urlRequest() -> URLRequest {
        return self
    }
}
