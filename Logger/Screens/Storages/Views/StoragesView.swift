//
//  StoragesView.swift
//  Logger
//
//  Created by Anton Kononenko on 7/29/22.
//

import SwiftUI

struct StoragesView: View {
    let storagesViewModel: StoragesViewModel = StoragesViewModel()
    @State private var isTargeted: Bool = false
    
    var body: some View {
        VStack {
            StoragesTopView(storagesViewModel: storagesViewModel)
            StoragestTableView(storagesViewModel: storagesViewModel)
        }
        .onDrop(of: [.json], isTargeted: $isTargeted, perform: { providers in
            guard let provider = providers.first else { return false }
            _ = provider.loadDataRepresentation(for: .json) { data, error in
                                if error == nil, let data {
                                    DispatchQueue.main.async {
                                        storagesViewModel.parseLoadedData(data)
                                    }
                                }
                            }
            return true
        })
    }
}

struct StoragesView_Previews: PreviewProvider {
    static var previews: some View {
        StoragesView()
    }
}
