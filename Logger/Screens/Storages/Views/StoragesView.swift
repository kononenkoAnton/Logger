//
//  StoragesView.swift
//  Logger
//
//  Created by Anton Kononenko on 7/29/22.
//

import SwiftUI

struct StoragesView: View {
    let storagesViewModel: StoragesViewModel = StoragesViewModel()
    var body: some View {
        VStack {
            StoragesTopView()
            
        }
    }
}

struct StoragesView_Previews: PreviewProvider {
    static var previews: some View {
        StoragesView()
    }
}
