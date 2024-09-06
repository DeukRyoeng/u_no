//
//  EetworkManager.swift
//  u_no
//
//  Created by 이득령 on 9/3/24.
//

import Foundation
import RxSwift
import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    //MARK: - Alamofire 사용
        func fetch<T: Decodable>(endpoint: Endpoint) -> Single<T> {
            return Single.create { observer in
    
                AF.request(endpoint.createURL()!, parameters: endpoint.queryParameters)
                    .validate() // 응답 검증
                    .responseDecodable(of: T.self) { response in
                        switch response.result {
                        case .success(let data):
                            observer(.success(data))
                            print("디코딩 성공")
                        case .failure(let error):
                            print("디코딩 실패 ERROR:\(error)")
                            observer(.failure(error))
                        }
                    }
                return Disposables.create()
    
            }
        }

    
//    func fetch<T: Decodable>(endpoint: Endpoint) -> Single<T> {
//        do {
//            let request = try endpoint.createEndpoint()
//            return Single.create { observer in
//                
//                let session = URLSession.shared
//                let task = session.dataTask(with: request) { data, response, error in
//                    
//                    if let error = error {
//                        observer(.failure(error))
//                        return
//                    }
//                    
//                    guard let data = data,
//                          let response = response as? HTTPURLResponse,
//                          (200..<300).contains(response.statusCode) else {
//                        observer(.failure(NetworkError.dataFetchFail))
//                        return
//                    }
//                    //MARK: - TextData를 JSON으로 변환
//                    
//                    if response.mimeType == "text/plain" {
//                        if let strData = String(data: data, encoding: String.Encoding.utf8),
//                           let jsonData = strData.data(using: .utf8) {
//                            
//                            do {
//                                let decodedData = try JSONDecoder().decode(T.self, from: jsonData)
//                                observer(.success(decodedData))
//                                print("called NetworkManager 디코딩 성공")
//                            } catch {
//                                print("called NetworkManager 디코딩 실패")
//                                observer(.failure(NetworkError.decodingFail))
//                            }
//                        } else {
//                            observer(.failure(NetworkError.decodingFail))
//                        }
//                    } else {
//                        // JSON 데이터로 변환
//                        do  {
//                            let decodedData = try JSONDecoder().decode(T.self, from: data)
//                            observer(.success(decodedData))
//                        } catch {
//                            let responseString = String(data: data, encoding: .utf8) ?? "데이터 없음"
//                            
//                        }
//                    }
//                }
//                
//                task.resume()
//                
//                return Disposables.create {
//                    task.cancel()
//                }
//            }
//        } catch let error {
//            return Single.create { observer in
//                observer(.failure(error))
//                return Disposables.create()
//            }
//        }
//    }
    
}

