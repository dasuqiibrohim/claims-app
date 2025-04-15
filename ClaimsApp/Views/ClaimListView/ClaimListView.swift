//
//  ClaimListView.swift
//  ClaimsApp
//
//  Created by Mufallah FD on 15/04/25.
//

import SwiftUI

struct ClaimListView: View {
    var body: some View {
        NavigationView {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Hello, world!")
            }
            .padding()
            .navigationTitle("Claims")
            .searchable(text: .constant(""), prompt: "Search Claims...")
        }
    }
}

#Preview {
    ClaimListView()
}
