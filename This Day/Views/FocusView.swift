//
//  FocusView.swift
//  This Day
//
//  Created by Heather Mason on 6/23/25.
//

import SwiftUI

struct FocusView: View {
    @State private var toDo: Bool = true
    
    var body: some View {
        HStack {
            Button("", systemImage: toDo ? "square" : "checkmark.square") {
//                $toDo.toggle
            }
            .foregroundColor(.black)
            .font(.title)
//            Image(systemName: "checkmark.square")
//            Image(systemName: "square")
            Text("Placeholder")
                .font(.largeTitle)
        }
    }
}

#Preview {
    FocusView()
}
