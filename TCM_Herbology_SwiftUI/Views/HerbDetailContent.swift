//
//  HerbDetailContent.swift
//  TCM_Herbology_SwiftUI
//
//  Created by Tai Kuchou on 2024/1/25.
//

import SwiftUI

struct HerbDetailContent: View {
    @State var data: HerbVO
    @State var v1 = false
    @State var v2 = false
    @State var v3 = false
    @State var v4 = false
    @State var v5 = false
    @State var v6 = false
    @State var v7 = false
    var body: some View {
        let list = data.fuFan.components(separatedBy: "|")
        //        print(list)
        return List {
            CellView(title: "Latin Name",content: getText(data.latinName))
            CellView(title: "Category",content: getText(data.category))
            CellView(title: "Common Name",content: getText(data.commonName))
            CellView(title: "Literal English",content: getText(data.literalEnglish))
            CellView(title: "Channels",content: getText(data.channels))
            VCellView(title: "Contraindications / Cautions",content: getText(data.contraindicationsCautions), isHiddn: $v1)
            VCellView(title: "Properties",content: getText(data.properties), isHiddn:$v2)
            VCellView(title: "Efficacy",content: getText(data.efficacy),isHiddn:$v3)
            VCellView(title: "Actions and Indications",content: getText(data.actionsIndications),isHiddn:$v4)
            VCellView(title: "Common Combinations",content: getText(data.commonCombinations),isHiddn:$v5)
            VCellView(title: "Others",content: getText(data.others),isHiddn:$v6)
            //FufanCellView(title: "FuFan", list: list,isHiddn:$v7)
            HStack{
                Text("FuFan")
                Spacer()
                if list.isEmpty{
                    Text("N/A")
                }
                Text("")
            }.gesture(tapperGesture)
            if !v7 {
                if !list.isEmpty {
                    ForEach(0..<list.count,id:\.self) { row in
                        FufanCellView(text: list[row],url:getLink(data:list[row]))
                    }
                }
            }
            //Spacer()

        }
        .listStyle(.plain)
        .navigationTitle(Text(data.chName+" ( \(data.pinyinName) )"))
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing:
                                HStack {
            Button(action: {
                if let url = URL(string: data.url){
                    UIApplication.shared.open(url)
                }
            }) {
                Image(systemName: "paperplane.circle")
                    .imageScale(.large)
            }
        }
        )

    }
    func getLink(data: String) -> String{
        if let endIdx = data.firstIndex(of: "=") {
            let fufan = "\(data[data.startIndex..<endIdx])"
            let urlString = FufanDAO.shared.getURL(fufan)
            return urlString
        }
        return ""
    }
    var tapperGesture: some Gesture {
        TapGesture().onEnded { _ in
            withAnimation(.easeOut(duration: 0.7)) {
                v7 = !v7
            }
        }
    }

    func getText(_ ret:String) -> String {
        var content = ret
        if content.isEmpty {
            content = "N/A"
        }else{
            content = "\(content.replacingOccurrences(of: "，", with: ","))"
            if content.contains("|") {
                content = "\(content.replacingOccurrences(of: "|", with: "\n"))"
            }
            if content.contains("•") {
                content = "\(content.replacingOccurrences(of: "•", with: "\n• "))"
            }
            if content.contains("◦") {
                content = "\(content.replacingOccurrences(of: "◦", with: "• "))"
            }
            if content.starts(with: "\n"){
                content = "\(content[content.index(content.startIndex, offsetBy: 1)..<content.endIndex])"
            }
        }
        return content
    }
}

#Preview {
    //HerbDetailContent()
    Text("")
}
