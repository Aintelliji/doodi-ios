//
//  ActivityRouter.swift
//  Doodie
//
//  Created by 수진 on 11/19/25.
//

import Alamofire
import Foundation

enum HomeRouter: URLRequestConvertible {
    
    case getCharacterInfo

    private var method: HTTPMethod {
        switch self {
        case .getCharacterInfo: return .get
        }
    }

    private var path: String {
        switch self {
        case .getCharacterInfo:
            return "/characters/me"
        }
    }

    private var parameters: Parameters? {
        switch self {
        case .getCharacterInfo:
            return nil
        }
    }

    private var encoding: ParameterEncoding {
        switch self {
        case .getCharacterInfo:
            return URLEncoding.default
        }
    }

    func asURLRequest() throws -> URLRequest {
        let base = try APIConfig.baseURL.asURL()
        var request = URLRequest(url: base.appendingPathComponent(path))

        request.method = method
        request.headers = APIConfig.defaultHeaders
        
        return try encoding.encode(request, with: parameters)
    }
}
