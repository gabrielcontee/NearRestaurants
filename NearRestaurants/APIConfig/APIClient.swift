//
//  APIClient.swift
//  NearRestaurants
//
//  Created by Gabriel Figueiredo Conde on 11/21/20.
//

import Foundation

protocol JSONDecodable {
    init?(JSON: [String : AnyObject])
}

protocol BaseRequestEndpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var parameters: [String: AnyObject] { get }
}

extension BaseRequestEndpoint {
    var queryComponents: [URLQueryItem] {
        var components = [URLQueryItem]()
        
        for (key, value) in parameters {
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            components.append(queryItem)
        }
        
        return components
    }
    
    var request: URLRequest {
        var components = URLComponents()
        components.scheme = "https"
        components.host = host
        components.path = path
        components.queryItems = queryComponents

        return URLRequest(url: components.url!)
    }
}

typealias JSON = [String: AnyObject]
typealias JSONCompletion = (JSON?, HTTPURLResponse?, NSError?) -> Void
typealias JSONTask = URLSessionDataTask

enum APIResult<T> {
    case success(T)
    case failure(Error)
}

protocol APIClient {
    
    var appErrorDomain: String { get } 
    
    var configuration: URLSessionConfiguration { get }
    var session: URLSession { get }
    
    func jsonTask(withRequest request: URLRequest, completion: @escaping JSONCompletion) -> JSONTask
    func perform<T: JSONDecodable>(_ request: URLRequest, parse: @escaping (JSON) -> T?, completion: @escaping (APIResult<T>) -> Void)
}

extension APIClient {
    func jsonTask(withRequest request: URLRequest, completion: @escaping JSONCompletion) -> JSONTask {
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            
            guard let HTTPResponse = response as? HTTPURLResponse else {
                let userInfo = [NSLocalizedDescriptionKey: NSLocalizedString("No HTTP Response", comment: "")]
                let error = NSError(domain: appErrorDomain, code: 10, userInfo: userInfo)
                completion(nil, nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, HTTPResponse, error as NSError?)
                return
            }
            
            switch HTTPResponse.statusCode {
            case 200:
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : AnyObject]
                    completion(json, HTTPResponse, nil)
                } catch let error as NSError {
                    completion(nil, HTTPResponse, error)
                }
            default:
                print("HTTP error status code: \(HTTPResponse.statusCode)\n")
            }
            
        })
        
        return task
    }
    
    func perform<T>(_ request: URLRequest, parse: @escaping (JSON) -> T?, completion: @escaping (APIResult<T>) -> Void) {
        let task = jsonTask(withRequest: request) { json, response, error in
            
            DispatchQueue.main.async {
                guard let json = json else {
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        let error = NSError(domain: appErrorDomain, code: 10, userInfo: nil)
                        completion(.failure(error))
                    }
                    return
                }
                
                if let resource = parse(json) {
                    completion(.success(resource))
                } else {
                    let error = NSError(domain: appErrorDomain, code: 10, userInfo: nil)
                    completion(.failure(error))
                }
            }
        }
        
        task.resume()
    }
    
    func performRequestTo<T: JSONDecodable>(_ endpoint: BaseRequestEndpoint, parse: @escaping (JSON) -> [T]?, completion: @escaping (APIResult<[T]>) -> Void) {
        
        let request = endpoint.request
        
        let task = jsonTask(withRequest: request) { json, response, error in
            
            DispatchQueue.main.async {
                guard let json = json else {
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        let error = NSError(domain: appErrorDomain, code: 10, userInfo: nil)
                        completion(.failure(error))
                    }
                    return
                }
                
                if let resource = parse(json) {
                    completion(.success(resource))
                } else {
                    let error = NSError(domain: appErrorDomain, code: 10, userInfo: nil)
                    completion(.failure(error))
                }
            }
        }
        
        task.resume()
        
    }
    
}






















