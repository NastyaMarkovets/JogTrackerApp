//
//  AuthorizationRouter.swift
//  JogTrackerApp
//
//  Created by Anastasia Markovets on 11/14/19.
//  Copyright © 2019 Lonely Tree Std. All rights reserved.
//

import Foundation
import Alamofire

enum JogsApi: JogsBaseApi {    

    case login(uuid: String)
    case addNewJog
    case updateExistingJog
    case syncJogs

    var method: HTTPMethod {
        switch self {
        case .login, .addNewJog:
            return .post
        case .updateExistingJog:
            return .put
        case .syncJogs:
            return .get
        }
    }

    var path: String {
        switch self {
        case .login:
            return Server.PathComponent.auth
        case .addNewJog:
            return ""
        case .updateExistingJog:
            return ""
        case .syncJogs:
            return ""
        }
    }

    var parameters: Parameters? {
        switch self {
        case .syncJogs:
            guard let accessToken = UserAccountManager.accessToken else { return nil }
            return [UserAccountManager.accessTokenKey: accessToken]
        default:
            return nil
        }
    }
    
    var queryParameters: [String: String]? {
        switch self {
        case .login(let uuid):
            return ["uuid" : uuid]
        default:
            return nil
        }
    }
    
}
