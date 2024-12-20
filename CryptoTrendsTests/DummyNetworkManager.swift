//
//  DummyNetworkManager.swift
//  CryptoTrendsTests
//
//  Created by Bhuiyan Wasif on 12/12/24.
//

import Foundation
import Combine

@testable import CryptoTrends

class DummyNetworkManager: NetworkManagerProtocol {
    var urlPath = ""
    
    func fetchData<T>(url: String, modelType: T.Type) -> AnyPublisher<T, any Error> where T : Decodable {
        let bundle = Bundle(for: DummyNetworkManager.self)
        let urlObj = bundle.url(forResource: urlPath, withExtension: "json")
        
        guard let urlObj else {
            return Fail(error: NetworkError.invalidData)
                .eraseToAnyPublisher()
        }
        
        do{
            let data = try Data(contentsOf: urlObj)
            
            let parsedData = try JSONDecoder().decode(modelType.self, from: data)
            
            return Just(parsedData)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }catch{
            return Fail(error: NetworkError.dataNotFound)
                .eraseToAnyPublisher()
        }
    }
    
}
