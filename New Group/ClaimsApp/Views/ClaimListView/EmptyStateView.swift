//
//  EmptyStateView.swift
//  ClaimsApp
//
//  Created by Mufallah FD on 15/04/25.
//

import SwiftUI

struct EmptyStateView: View {
    var body: some View {
        VStack {
            Image(systemName: "exclamationmark.triangle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .foregroundColor(.gray)
            
            Text("No data available at the moment.\nPlease try again later or check back soon.")
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding()
                .foregroundColor(.gray)
        }
        .padding()
    }
}
