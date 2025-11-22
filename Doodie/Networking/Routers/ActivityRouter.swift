//
//  ActivityRouter.swift
//  Doodie
//
//  Created by 수진 on 11/19/25.
//

import Alamofire
import Foundation

enum ActivityRouter: URLRequestConvertible {
    
    case getActivityTypes
    case getActivitiesById(activityId: Int)

    private var method: HTTPMethod {
        switch self {
        case .getActivityTypes: return .get
        case .getActivitiesById: return .get
        }
    }

    private var path: String {
        switch self {
        case .getActivityTypes:
            return "/activity-types"
        case .getActivitiesById(let activityId):
            return "/activities/\(activityId)"
        }
    }

    private var parameters: Parameters? {
        switch self {
        case .getActivityTypes:
            return nil
        case .getActivitiesById(let activityId):
            return nil
        }
    }

    private var encoding: ParameterEncoding {
        switch self {
        case .getActivityTypes:
            return URLEncoding.default
        case .getActivitiesById:
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
