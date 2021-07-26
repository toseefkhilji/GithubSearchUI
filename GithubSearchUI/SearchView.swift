//
//  SwiftUIView.swift
//  GithubSearchUI
//
//  Created by Toseef on 7/26/21.
//

import SwiftUI

struct SearchView: View {

    @State private var query: String = ""
    @EnvironmentObject var repoStore: ReposStore

    var body: some View {
        NavigationView {
            List {
                HStack {
                    Image(systemName: "magnifyingglass.circle")
                        .foregroundColor(.red)
                    TextField("Search here", text: $query, onCommit: fetch)
                        .foregroundColor(.red)
                    if repoStore.isLoading {
                        ProgressView().progressViewStyle(CircularProgressViewStyle(tint: .red))
                    }
                }.padding()
                .background(Color.init(white: 0.9))
                .cornerRadius(8)

                ForEach(repoStore.repos) { repo in
                    RepoRow(repo: repo)
                        .padding(4)
                }
            }.navigationBarTitle(Text("Search"))
        }.onAppear(perform: fetch)
    }

    private func fetch() {
        print("started")
        repoStore.fetch(matching: query) {
            print("Fetched")
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView().environmentObject(ReposStore(service: .init()))
    }
}
