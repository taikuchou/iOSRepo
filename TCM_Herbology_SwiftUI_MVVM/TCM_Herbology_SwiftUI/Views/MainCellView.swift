//
//  MainCellView.swift
//  TCM_Herbology_SwiftUI
//
//  Created by Tai Kuchou on 2024/1/25.
//

import SwiftUI

struct MainCellView: View {
    @State var data: HerbVO
    var body: some View {
        return VStack{
            CellView(title: data.pinyinName,content: data.chName)
            HStack{
                Text(data.channels.replacingOccurrences(of: "，", with: ","))
                Spacer()
            }
        }
    }
}


#Preview {
    var vo = HerbVO()
    vo.chName = ""
    return MainCellView(data: vo)
}
