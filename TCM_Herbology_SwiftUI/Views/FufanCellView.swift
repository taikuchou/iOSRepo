//
//  FufanCellView.swift
//  TCM_Herbology_SwiftUI
//
//  Created by Tai Kuchou on 2024/1/25.
//

import SwiftUI

struct FufanCellView: View {

    @State var text: String = ""
    @State var url: String = ""
    var body: some View {
        if url.isEmpty {
            HStack{
                Text(text)
                Spacer()
            }

        }else{
            HStack{
                Link(text,
                     destination: URL(string: url)!)
                Spacer()
            }
        }
    }
}

