//
//  FufanCellView.swift
//  TCM_Herbology_SwiftUI
//
//  Created by Tai Kuchou on 2024/1/25.
//

import SwiftUI

struct FufanCellView: View {
    @EnvironmentObject var viewModel: HerbDetailViewModel
    @State var text: String
    @State var list: [String]
    @Binding var isHiddn: Bool
    var body: some View {
        VStack{
            HStack{
                Text(text)
                Spacer()
                if list.isEmpty{
                    Text("N/A")
                }
            }.gesture(tapperGesture)
            Spacer().frame(height: 10)
            if !list.isEmpty && !isHiddn{
                ForEach(0..<list.count,id:\.self){ idx in
                    let txt = list[idx]
                    HStack{
                        if let url = URL(string: viewModel.getLink(txt)){
                            Link(txt,
                                 destination: url).foregroundColor(Color.purple)
                        }else{
                            Text(txt)
                        }
                        Spacer()
                    }
                    Spacer().frame(height: 10)
                }
            }
        }
    }
    var tapperGesture: some Gesture {
        TapGesture().onEnded { _ in
            withAnimation(.easeOut(duration: 0.5)) {
                isHiddn = !isHiddn
            }
        }
    }


}

