//
//  ContentView.swift
//  This Day
//
//  Created by Heather Mason on 6/23/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Image("LandsEnd")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            FocusView()
        }
    }
}

#Preview {
    ContentView()
}
