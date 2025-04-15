//
//  ClaimListView.swift
//  ClaimsApp
//
//  Created by Mufallah FD on 15/04/25.
//

import SwiftUI

struct ClaimListView: View {
    @StateObject private var viewModel = ClaimListViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                if viewModel.isLoading {
                    ProgressView("Loading Claims...")
                        .padding()
                } else {
                    if viewModel.filteredClaims.isEmpty {
                        EmptyStateView()
                    } else {
                        List(viewModel.filteredClaims) { claim in
                            NavigationLink(destination: ClaimDetailView(claim: claim)) { ClaimRowView(claim: claim) }
                        }
                        .listStyle(PlainListStyle())
                    }
                }
            }
            .navigationTitle("Claims")
            .searchable(text: $viewModel.searchText, prompt: "Search Claims...")
            .alert(isPresented: Binding<Bool>(
                get: { viewModel.errorMessage != nil },
                set: { _ in viewModel.errorMessage = nil }
            )) {
                Alert(title: Text("Oops, something went wrong"),
                      message: Text(viewModel.errorMessage ?? "Unknown error"),
                      dismissButton: .default(Text("OK")))
            }
        }
    }
}

#Preview {
    ClaimListView()
}
