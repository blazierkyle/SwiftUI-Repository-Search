//
//  URLSession+Publisher.swift
//  SwiftUINetworking
//
//  Created by Kyle Blazier on 6/9/19.
//  Copyright © 2019 Kyle Blazier. All rights reserved.
//

import Foundation
import Combine

extension URLSession: Publisher {
    
    public typealias Output = [Repository]
    public typealias Failure = Error
    
    enum APIError: Error {
        case invalidResponse
        case noData
        case serverError(statusCode: Int, error: Error?)
        case other(Error)
    }
    
    func send(request: URLRequest) -> AnyPublisher<Data, APIError> {
        AnyPublisher<Data, APIError> { subscriber in
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard let response = response as? HTTPURLResponse else {
                    subscriber.receive(completion: .failure(.invalidResponse))
                    return
                }
                
                guard 200..<300 ~= response.statusCode else {
                    let serverError = APIError.serverError(statusCode: response.statusCode, error: error)
                    subscriber.receive(completion: .failure(serverError))
                    return
                }
                
                guard let data = data else {
                    subscriber.receive(completion: .failure(.noData))
                    return
                }
                
                if let error = error {
                    subscriber.receive(completion: .failure(.other(error)))
                    return
                }
                
                _ = subscriber.receive(data)
                subscriber.receive(completion: .finished)
            }
            
            task.resume()
        }
    }
    
    public func receive<S>(subscriber: S) where S : Subscriber, Failure == S.Failure, Output == S.Input {
        subscribe(subscriber)
    }
}
