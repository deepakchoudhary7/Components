//
//  ViewController.swift
//  FoodyPOS
//
//  Created by rajat on 26/07/18.
//  Copyright © 2018 com.tutist. All rights reserved.
//
//  All API routes are defined in this file. This file act as a Router for all API requests

import Alamofire

enum APIRouter: URLRequestConvertible {
    static let kMerchentId = "VNvJVYHp5LJkYzpUWr28b7hmAkQ0TJWg"
    
    case createSession
    case bannerList(String)
    case latestProduct
    case featureProduct
    case specialsProduct
    case login([String:Any])
    case socialLogin([String:Any])
    case signup([String:Any])
    case logout([String:Any])
    case getcart
    case getCategories
    case getCategoriesById
    
    
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case .createSession, .bannerList, .latestProduct, .featureProduct, .specialsProduct, .getcart, .getCategories, .getCategoriesById:
            return .get
        case .login, .signup, .logout, .socialLogin:
            return .post
        }
    }
    
    private var basePath:String {
        return ""
    }
    
    // MARK: - Path
    private var path: String {
        switch self {
            
        case .createSession:
            return "/session"
            
        case .bannerList(let bannerId):
            return "/banners/\(bannerId)"
            
        case .latestProduct:
            return "/latest"
            
        case .featureProduct:
            return "/featured"
            
        case .specialsProduct:
            return "/specials"
            
        case .login:
            return "/login"
            
        case .socialLogin:
            return "/sociallogin"
            
        case .signup:
            return "/register"
        case .logout:
            return "/logout"
        case .getcart:
            return "/cart"
        case  .getCategories:
            return "/categories"
        case .getCategoriesById:
            return "/categories/60"
        }
    }
    
    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        case .createSession, .bannerList, .latestProduct, .featureProduct, .specialsProduct, .getcart, .getCategories , .getCategoriesById:
            return nil
            
        case .login(let parameters):
            return parameters
            
        case .socialLogin(let parameters):
            return parameters
            
        case .signup(let parameters):
            return parameters
            
        case .logout(let parameters):
            return parameters
            
        }
    }
    
    private var merchantID: String? {
        switch self {
        case .createSession, .bannerList, .latestProduct, .featureProduct, .specialsProduct, .login, .socialLogin, .signup, .logout, .getcart, .getCategories , .getCategoriesById:
            return APIRouter.kMerchentId
        }
    }
    
    private var sessionID: String? {
        switch self {
            
        case .createSession:
            return nil
    case .bannerList, .latestProduct, .featureProduct, .specialsProduct, .login, .socialLogin, .signup, .logout, .getcart ,.getCategories, .getCategoriesById:
            return UserManager.sessionId ?? nil
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        switch method {
        case .get:
            return URLEncoding.queryString
        case .post:
            return JSONEncoding.default
            
        default:
            return JSONEncoding.default
        }
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try K.ProductionServer.baseURL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue

        if let merchantId = merchantID {
            urlRequest.setValue(merchantId, forHTTPHeaderField: HTTPHeaderField.merchantId.rawValue)
        }
        if let sessionId = merchantID {
            urlRequest.setValue(sessionId, forHTTPHeaderField: HTTPHeaderField.sessionId.rawValue)
        }
        urlRequest = try parameterEncoding.encode(urlRequest, with: parameters)
        return urlRequest
    }
}

