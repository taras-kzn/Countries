//
//  Connectivity.swift
//  TestTaskCountries
//
//  Created by admin on 25.01.2020.
//  Copyright © 2020 admin. All rights reserved.
//

import Alamofire

class Connectivity {
    class func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}
