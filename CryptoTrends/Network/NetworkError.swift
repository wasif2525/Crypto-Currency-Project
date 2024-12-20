//
//  NetworkError.swift
//  CryptoTrends
//
//  Created by Bhuiyan Wasif on 12/12/24.
//

import Foundation

enum NetworkError: Error{
    case invalidURL
    case invalidResponse
    case invalidData
    case invalidJSON
    case invalidHTTPStatusCode
    case parsingError
    case dataNotFound
    
    var errorDescription: String {
        switch self{
        case .invalidURL: return "[😮‍💨] The Url is invaid."
        case .invalidResponse: return "[🤯] The response is invalid."
        case .invalidData: return "[😞] The data is invalid."
        case .invalidJSON: return "[😓] The JSON is invalid."
        case .invalidHTTPStatusCode: return "[🤦‍♂️] The HTTP status code is invalid."
        case .parsingError: return "[☹️] Not able to parse the JSON."

        case .dataNotFound: return "[😭] Data is not available. Please try again in a bit!"
        }
    }
}
