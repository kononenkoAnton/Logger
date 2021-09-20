//
//  InfoViewLabel.swift
//  Logger
//
//  Created by Anton Kononenko on 9/20/21.
//

import SwiftUI

struct InfoViewLabel: View {
    var title: String
    var description: String
    
    var body: some View {
        
        HStack {
            Text(title).bold()
            Text(description)
            Spacer()
        }
    }
}

struct InfoViewLabel_Previews: PreviewProvider {
    static var previews: some View {
        InfoViewLabel(title: "Message: ", description: "We have a big bug!")
    }
}
