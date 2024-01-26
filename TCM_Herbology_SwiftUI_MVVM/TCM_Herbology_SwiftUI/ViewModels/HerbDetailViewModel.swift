//
//  HerbDetailViewModel.swift
//  TCM_Herbology_SwiftUI_MVVVM
//
//  Created by Tai Kuchou on 2024/1/26.
//

import Foundation
final class HerbDetailViewModel: ObservableObject {
    @Published var data: HerbVO = HerbVO()
    @Published var hideStatus = [false,false,false,false,false,false,false]
    init(data: HerbVO, hideStatus: [Bool] = [false,false,false,false,false,false,false]) {
        self.data = data
        self.hideStatus = hideStatus
    }
    func getLink(_ fufanText: String) -> String{
        if let endIdx = fufanText.firstIndex(of: "=") {
            let fufan = "\(fufanText[fufanText.startIndex..<endIdx])"
            let urlString = FufanDAO.shared.getURL(fufan)
            return urlString
        }
        return ""
    }
}
