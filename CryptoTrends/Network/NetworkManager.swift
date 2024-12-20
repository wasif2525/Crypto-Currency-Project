//
//  NetworkManager.swift
//  CryptoTrends
//
//  Created by Bhuiyan Wasif on 12/12/24.
//

import Foundation
import Combine

protocol NetworkManagerProtocol{
    func fetchData<T: Decodable>(url: String, modelType: T.Type) -> AnyPublisher<T, Error>
}

class NetworkManager{
    let urlSession: URLSession
    
    init(urlSession: URLSession = URLSession.shared){
        self.urlSession = urlSession
    }
}

extension NetworkManager: NetworkManagerProtocol{
    func fetchData<T: Decodable>(url: String, modelType: T.Type) -> AnyPublisher<T, Error>{
        guard let url = URL(string: url) else{
            return Fail(error: NetworkError.invalidURL)
                .eraseToAnyPublisher()
        }
        
        let dataPublisher = self.urlSession.dataTaskPublisher(for: url)
        
        let operatedData = dataPublisher.tryMap { result in
            guard let response = result.response as? HTTPURLResponse else {
                throw NetworkError.invalidResponse
            }
            guard (200...299).contains(response.statusCode) else{
                throw NetworkError.invalidHTTPStatusCode
            }
            return result.data
        }
            .decode(type: modelType, decoder: JSONDecoder())
        return operatedData
            .eraseToAnyPublisher()
    }
}

