//
//  FufanVO.swift
//  TCM_Herbology
//
//  Created by Tai Kuchou on 2024/1/24.
//

import Foundation
import CoreData

struct FufanVO: Codable{

    var url = ""
    var name = ""
    var desc = ""
    private enum CodingKeys: String, CodingKey {
        case url = "URL"
        case name = "NAME"
        case desc = "DESC"
    }
    init(){

    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        url = try values.decode(String.self, forKey: .url)
        name = try values.decode(String.self, forKey: .name)
        desc = try values.decode(String.self, forKey: .desc)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(url, forKey: .url)
        try container.encode(name, forKey: .name)
        try container.encode(desc, forKey: .desc)
    }
}

extension FufanVO: CoreDataTransform{
    typealias T = FufanVO
    static func fromNSManagedObject(_ data: NSManagedObject) -> T {
        var ret = FufanVO()
        ret.url =  data.value(forKeyPath: "url") as? String ?? ""
        ret.name =  data.value(forKeyPath: "name") as? String ?? ""
        ret.desc =  data.value(forKeyPath: "desc") as? String ?? ""
        return ret
    }
}



