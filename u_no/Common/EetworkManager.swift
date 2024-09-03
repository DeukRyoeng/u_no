//
//  EetworkManager.swift
//  u_no
//
//  Created by 이득령 on 9/3/24.
//

import Foundation
import RxSwift

class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    func fetch<T: Decodable>(endpoint: Endpoint) -> Single<T> {
        do {
            let request = try endpoint.createEndpoint()
            return Single.create { observer in
                
                let session = URLSession.shared
                let task = session.dataTask(with: request) { data, response, error in
                    
                    if let error = error {
                        observer(.failure(error))
                        return
                    }
                    
                    guard let data = data,
                          let response = response as? HTTPURLResponse,
                          (200..<300).contains(response.statusCode) else {
                        observer(.failure(NetworkError.dataFetchFail))
                       return
                    }
                    
                    do {
                        let decodedData = try JSONDecoder().decode(T.self, from: data)
                        observer(.success(decodedData))
                    } catch {
                        let responseString = String(data: data, encoding: .utf8) ?? "불러온 데이터 없음"
                        print("Decoding failed. Response data: \(responseString)")
                        observer(.failure(NetworkError.decodingFail))
                    }
                }
                
                task.resume()
                
                return Disposables.create {
                    task.cancel()
                }
            }
        } catch let error {
            return Single.create { observer in
                observer(.failure(error))
                return Disposables.create()
            }
        }
    }
}
