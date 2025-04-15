//
//  ClaimRowView.swift
//  ClaimsApp
//
//  Created by Mufallah FD on 15/04/25.
//

import SwiftUI

struct ClaimRowView: View {
    let claim: Claim
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(claim.title)
                .font(.headline)
            Text(claim.body)
                .font(.subheadline)
                .lineLimit(2)
            Text("Claim ID: \(claim.id) | Claimant ID: \(claim.userID)")
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding(.vertical, 4)
    }
}
