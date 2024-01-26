//
//  VCellView.swift
//  TCM_Herbology_SwiftUI
//
//  Created by Tai Kuchou on 2024/1/25.
//

import SwiftUI
struct VCellView: View {
    @State var title: String = ""
    @State var content: String = ""
    @Binding var isHiddn: Bool
    var hiddenView: some View {
        VStack{
            HStack{
                Text(title)
                Spacer()
            }
        }
    }
    var body: some View {

        return VStack{
            HStack{
                Text(title)
                Spacer()
            }
            if !isHiddn {
                HStack{
                    Text(content)
                    Spacer()
                }
            }
        }.gesture(tapperGesture)


    }
    var tapperGesture: some Gesture {
        TapGesture().onEnded { _ in
            withAnimation(.easeOut(duration: 0.7)) {
                isHiddn = !isHiddn
            }
        }
    }
}
