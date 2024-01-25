//
//  HerbVO.swift
//  TCM_Herbology
//
//  Created by Tai Kuchou on 2024/1/22.
//

import Foundation
import CoreData

struct HerbVO: Codable{
    var hid: Int? = 0
    var url = ""
    var category  = ""
    var efficacy  = ""
    var group  = ""
    var subgroup1  = ""
    var subgroup2  = ""
    var pinyinName  = ""
    var chName  = ""
    var latinName = ""
    var properties  = ""
    var channels  = ""
    var actionsIndications  = ""
    var dosage  = ""
    var commonName  = ""
    var literalEnglish  = ""
    var contraindicationsCautions  = ""
    var commonCombinations  = ""
    var others  = ""
    var fuFan = ""
    private enum CodingKeys: String, CodingKey {
        case hid
        case url = "URL"
        case category = "SUBJECT"
        case efficacy = "EFFECT"
        case group = "GROUP"
        case subgroup1  = "SUBGROUP_1"
        case subgroup2  = "SUBGROUP_2"
        case pinyinName  = "PINYIN_NAME"
        case chName  = "NAME"
        case latinName  = "LATIN_NAME"
        case properties  = "PROPERTIES"
        case channels  = "CHANNELS"
        case actionsIndications  = "ACTIONS_INDICATIONS"
        case dosage  = "DOSAGE"
        case commonName  = "COMMON_NAME"
        case literalEnglish  = "LITERAL_ENGLISH"
        case contraindicationsCautions  = "CONTRAINDICATIONS_CAUTIONS"
        case commonCombinations  = "COMMON_COMBINATIONS"
        case others = "OTHERS"
        case fuFan = "FUFAN"
    }
    init(){

    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        url = try values.decode(String.self, forKey: .url)
        category = try values.decode(String.self, forKey: .category)
        efficacy = try values.decode(String.self, forKey: .efficacy)
        group = try values.decode(String.self, forKey: .group)
        subgroup1 = try values.decode(String.self, forKey: .subgroup1)
        subgroup2 = try values.decode(String.self, forKey: .subgroup2)
        pinyinName = try values.decode(String.self, forKey: .pinyinName)
        chName = try values.decode(String.self, forKey: .chName)
        latinName = try values.decode(String.self, forKey: .latinName)
        properties = try values.decode(String.self, forKey: .properties)
        channels = try values.decode(String.self, forKey: .channels)
        actionsIndications = try values.decode(String.self, forKey: .actionsIndications)
        dosage = try values.decode(String.self, forKey: .dosage)
        commonName = try values.decode(String.self, forKey: .commonName)
        literalEnglish = try values.decode(String.self, forKey: .literalEnglish)
        contraindicationsCautions = try values.decode(String.self, forKey: .contraindicationsCautions)
        commonCombinations = try values.decode(String.self, forKey: .commonCombinations)
        others = try values.decode(String.self, forKey: .others)
        fuFan = try values.decode(String.self, forKey: .fuFan)

//        let additionalInfo = try values.nestedContainer(keyedBy: AdditionalInfoKeys.self, forKey: .additionalInfo)
//                elevation = try additionalInfo.decode(Double.self, forKey: .elevation)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(url, forKey: .url)
        try container.encode(category, forKey: .category)
        try container.encode(efficacy, forKey: .efficacy)
        try container.encode(group, forKey: .group)
        try container.encode(subgroup1, forKey: .subgroup1)
        try container.encode(subgroup2, forKey: .subgroup2)
        try container.encode(pinyinName, forKey: .pinyinName)
        try container.encode(chName, forKey: .chName)
        try container.encode(latinName, forKey: .latinName)
        try container.encode(properties, forKey: .properties)
        try container.encode(channels, forKey: .channels)
        try container.encode(actionsIndications, forKey: .actionsIndications)
        try container.encode(dosage, forKey: .dosage)
        try container.encode(commonName, forKey: .commonName)
        try container.encode(literalEnglish, forKey: .literalEnglish)
        try container.encode(contraindicationsCautions, forKey: .contraindicationsCautions)
        try container.encode(commonCombinations, forKey: .commonCombinations)
        try container.encode(others, forKey: .others)
        try container.encode(fuFan, forKey: .fuFan)

        //            var additionalInfo = container.nestedContainer(keyedBy: AdditionalInfoKeys.self, forKey: .additionalInfo)
        //            try additionalInfo.encode(elevation, forKey: .elevation)
    }
}

extension HerbVO: CoreDataTransform{
    typealias T = HerbVO
    static func fromNSManagedObject(_ data: NSManagedObject) -> T {
        var ret = HerbVO()
        ret.url =  data.value(forKeyPath: "url") as? String ?? ""
        ret.category =  data.value(forKeyPath: "category") as? String ?? ""
        ret.efficacy =  data.value(forKeyPath: "efficacy") as? String ?? ""
        ret.group =  data.value(forKeyPath: "group") as? String ?? ""
        ret.subgroup1 =  data.value(forKeyPath: "subgroup1") as? String ?? ""
        ret.subgroup2 =  data.value(forKeyPath: "subgroup2") as? String ?? ""
        ret.pinyinName =  data.value(forKeyPath: "pinyinName") as? String ?? ""
        ret.chName =  data.value(forKeyPath: "name") as? String ?? ""
        ret.latinName =  data.value(forKeyPath: "latinName") as? String ?? ""
        ret.properties =  data.value(forKeyPath: "properties") as? String ?? ""
        ret.channels =  data.value(forKeyPath: "channels") as? String ?? ""
        ret.actionsIndications =  data.value(forKeyPath: "actionsIndications") as? String ?? ""
        ret.dosage =  data.value(forKeyPath: "dosage") as? String ?? ""
        ret.commonName =  data.value(forKeyPath: "commonName") as? String ?? ""
        ret.literalEnglish =  data.value(forKeyPath: "literalEnglish") as? String ?? ""
        ret.contraindicationsCautions =  data.value(forKeyPath: "contraindicationsCautions") as? String ?? ""
        ret.commonCombinations =  data.value(forKeyPath: "commonCombinations") as? String ?? ""
        ret.others =  data.value(forKeyPath: "others") as? String ?? ""
        ret.fuFan =  data.value(forKeyPath: "fuFan") as? String ?? ""
        return ret
    }
}


