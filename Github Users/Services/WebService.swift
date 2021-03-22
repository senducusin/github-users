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
    case persistingError
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
    func load<T>(resource:Resource<T>, completion:@escaping(Result<[User],NetworkError>)->()){
        var request = URLRequest(url: resource.url)
        request.httpBody = resource.httpBody
        request.httpMethod = resource.httpMethod.rawValue
        request.addValue("json/application", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard error == nil,
                  let data = data else {
                if let _ = error {
                    completion(.failure(.domainError))
                }
                return
              }
            
            do {
                let dataResults = try JSONDecoder().decode(T.self, from: data)
          
                if let dataResults = dataResults as? [ResponseGithubUser] {
                    
                    DispatchQueue.main.async {
                   
                        PersistenceService.shared.saveUsers(githubUsers: dataResults) { result in
                            switch(result){
                            case .success(let users):
                                completion(.success(users))
                            case .failure(_):
                                completion(.failure(.persistingError))
                            }
                            
                        }
                    }
                }
                
                
            }catch{
                completion(.failure(.decodeError))
            }
            
        }.resume()
    }
}
