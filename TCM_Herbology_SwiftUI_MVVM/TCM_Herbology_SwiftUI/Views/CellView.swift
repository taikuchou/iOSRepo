//
//  CellView.swift
//  TCM_Herbology_SwiftUI
//
//  Created by Tai Kuchou on 2024/1/25.
//

import SwiftUI

struct CellView: View {
    @State var title: String = ""
    @State var content: String = ""
    var body: some View {
        return HStack{
            Text(title)
            Spacer()
            Text(content).foregroundColor(Color.secondary)
        }
    }
}

#Preview {
    CellView()
}
