//
//  ReelView.swift
//  Slot Machine
//
//  Created by Itunu Raimi on 25/02/2021.
//

import SwiftUI

struct ReelView: View {
    // MARK: - PROPERTIES
    
    // MARK: - BODY
    var body: some View {
        Image("gfx-reel")
            .resizable()
            .modifier(ImageModifier())
    }
}

// MARK: - PREVIEW
struct ReelView_Previews: PreviewProvider {
    static var previews: some View {
        ReelView()
    }
}
