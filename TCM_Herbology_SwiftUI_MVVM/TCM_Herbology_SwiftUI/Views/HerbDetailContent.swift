//
//  HerbDetailContent.swift
//  TCM_Herbology_SwiftUI
//
//  Created by Tai Kuchou on 2024/1/25.
//

import SwiftUI

struct HerbDetailContent: View {
    @EnvironmentObject var viewModel: HerbDetailViewModel
    var body: some View {
        let data = viewModel.data
        let list = data.fuFan.components(separatedBy: "|")
        //        print(list)
        return List {
            CellView(title: "Latin Name",content: getText(data.latinName))
            CellView(title: "Category",content: getText(data.category))
            CellView(title: "Common Name",content: getText(data.commonName))
            CellView(title: "Literal English",content: getText(data.literalEnglish))
            CellView(title: "Channels",content: getText(data.channels))
            VCellView(title: "Contraindications / Cautions",content: getText(data.contraindicationsCautions), isHiddn: $viewModel.hideStatus[0])
            VCellView(title: "Properties",content: getText(data.properties), isHiddn:$viewModel.hideStatus[1])
            VCellView(title: "Efficacy",content: getText(data.efficacy),isHiddn:$viewModel.hideStatus[2])
            VCellView(title: "Actions and Indications",content: getText(data.actionsIndications),isHiddn:$viewModel.hideStatus[3])
            VCellView(title: "Common Combinations",content: getText(data.commonCombinations),isHiddn:$viewModel.hideStatus[4])
            VCellView(title: "Others",content: getText(data.others),isHiddn:$viewModel.hideStatus[5])
            FufanCellView(text: "Fufan", list: list, isHiddn:$viewModel.hideStatus[6]).environmentObject(viewModel)
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
