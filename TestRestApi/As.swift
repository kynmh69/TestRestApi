//
//  As.swift
//  TestRestApi
//
//  Created by Hiroki Kayanuma on 2020/04/01.
//  Copyright © 2020 Hiroki Kayanuma. All rights reserved.
//

import Foundation
import Alamofire
// APIを入れるための構造体
struct AddressModel: Codable {
    var results: [Result]

    struct Result: Codable {
        var address1: String
        var address2: String
        var address3: String
        var kana1: String
        var kana2: String
        var kana3: String
    }
}
class Address {
    private var addresses = AddressModel
    //住所の取得
    private func getAddress(zipcode: String) {
        let baseUri = "http://zipcloud.ibsnet.co.jp/api/"
        let uri = "\(baseUri)search"
        let searchUri = URL(string: uri)
        let headers: HTTPHeaders = ["Content-Type": "application/json"]
        let parameters: [String: Any] = ["zipcode": zipcode]
        AF.request(searchUri!, method: .get, parameters: parameters, headers: headers).responseJSON { response in
            guard let data = response.data else {
                return
            }
            do {
                self.addresses = try JSONDecoder().decode(AddressModel.self, from: data)
            } catch let error {
                print("Error: \(error)")
            }
        }
        
    }
}

