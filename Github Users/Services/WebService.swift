//
//  WebService.swift
//  Github Users
//
//  Created by Jansen Ducusin on 3/22/21.
//

import Foundation

enum NetworkError: Error {
    case domainError
    case urlError
    case decodeError
    case persistenceError
}

enum HttpMethod: String {
    case post = "POST"
    case get = "GET"
}

struct Resource<T:Decodable>{
    var url: URL
    var httpMethod: HttpMethod = .get
    var httpBody: Data? = nil
}

extension Resource {
    init(url:URL){
        self.url = url
    }
}

class WebService{
    
    func load<T>(resource: Resource<T>, completion:@escaping(Result<T,NetworkError>)->()){
        var request = URLRequest(url: resource.url)
        request.httpBody = resource.httpBody
        request.httpMethod = resource.httpMethod.rawValue
        request.addValue("json/application", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard error == nil,
                  let data = data else {
                completion(.failure(.domainError))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(.success(result))
            }catch{
                print("DEBUG error in decoding")
                completion(.failure(.decodeError))
            }
        }.resume()
    }
}
