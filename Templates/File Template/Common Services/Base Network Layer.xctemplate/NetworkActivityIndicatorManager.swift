//
//  NetworkActivityIndicatorManager.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___COPYRIGHT___
//

import UIKit

class NetworkActivityIndicatorManager {
    
    private static var loadingCount = 0
    
    class func networkOperationStarted() {
        DispatchQueue.main.async {
            if loadingCount == 0 {
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
            }
            loadingCount += 1
        }
    }
    
    class func networkOperationFinished() {
        DispatchQueue.main.async {
            if loadingCount > 0 {
                loadingCount -= 1
            }
            if loadingCount == 0 {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        }
    }
}
