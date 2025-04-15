//
//  ClaimDetailView.swift
//  ClaimsApp
//
//  Created by Mufallah FD on 15/04/25.
//

import SwiftUI

struct ClaimDetailView: View {
    let claim: Claim
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Title section
            Text(claim.title)
                .font(.title3.bold())
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color(.systemGray6))
                .cornerRadius(8)
            
            // ID section
            VStack(alignment: .leading, spacing: 4) {
                Text("Claim ID: \(claim.id)")
                    .font(.subheadline)
                Text("Claimant ID: \(claim.userID)")
                    .font(.subheadline)
            }
            
            // Description box
            Text(claim.body)
                .padding()
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .frame(minHeight: 150, alignment: .topLeading)
                .background(Color(.systemGray6))
                .cornerRadius(8)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Claim Detail")
        .navigationBarTitleDisplayMode(.inline)
    }
}
