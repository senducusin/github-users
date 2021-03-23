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

struct Resource<T:Codable>{
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
                completion(.failure(.decodeError))
            }
        }.resume()
    }
    
    func loadToCoreData<T>(resource:Resource<T>, completion:@escaping(NetworkError?)->()){
        var request = URLRequest(url: resource.url)
        request.httpBody = resource.httpBody
        request.httpMethod = resource.httpMethod.rawValue
        request.addValue("json/application", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard error == nil,
                  let data = data else {
                if let _ = error {
                    completion(.domainError)
                }
                return
              }
            

            do {
                
                let decoder = JSONDecoder()
                decoder.userInfo[CodingUserInfoKey.context!] = PersistenceService.shared.container.viewContext
                
                let _ = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    
                    
                    PersistenceService.shared.save { error in
                        if let error = error {
                            print(error.localizedDescription)
                            completion(.persistenceError)
                            return
                        }
                        completion(nil)
                    }
                }

            }catch{
                print("failed: \(resource.url)")
                completion(.decodeError)
            }

            
        }.resume()
    }
}
