//
//  Model.swift
//  NestedTableview
//
//  Created by Kishan Barmawala on 02/08/23.
//

import Foundation

struct FirstLevelData {
    var name: String
    var isExpanded: Bool
    var detailData: [DetailData]
}

struct DetailData {
    var name: String
//    var age: String
//    var gender: String
//    var percentage: String
}
