//
//  MainNavigationLinkView.swift
//  TCM_Herbology_SwiftUI
//
//  Created by Tai Kuchou on 2024/1/25.
//

import SwiftUI

struct MainNavigationLinkView: View {
    @State var data: HerbVO
    var body: some View {
        NavigationLink {
            HerbDetailContent(data: data)
        } label: {
            MainCellView(data: data)
        }
    }
}
