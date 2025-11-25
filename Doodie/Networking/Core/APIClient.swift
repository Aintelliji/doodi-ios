//
//  APIClient.swift
//  Doodie
//
//  Created by 수진 on 11/19/25.
//
import Alamofire

final class APIClient {

    static let shared = APIClient()
    private init() {}

    func request<T: Decodable>(_ convertible: URLRequestConvertible, type: T.Type) async throws -> T {
        return try await withCheckedThrowingContinuation { continuation in
            
            AF.request(convertible)
                .validate()
                .responseDecodable(of: BaseResponse<T>.self) { response in
                    
                    
                    // 🔍 raw JSON 항상 찍기
                            if let data = response.data,
                               let json = String(data: data, encoding: .utf8) {
                                print("📦 [RAW RESPONSE]:")
                                print(json)
                            }
                    
                    switch response.result {
                        
                    // 200~209
                    case .success(let value):
                        if value.status != 200 {
                            continuation.resume(throwing: APIError.serverError(message: value.message))
                            return
                        }
                        // 데이터가 널일때
                        guard let data = value.data else {
                            continuation.resume(throwing: APIError.decodingError)
                            return
                        }
                        
                        continuation.resume(returning: data)

                    // 에러 응답
                    case .failure(let error):
                        print("통신 url: \(convertible.urlRequest)")
                        
                        continuation.resume(throwing: error)
                    }
                }
        }
    }
}
