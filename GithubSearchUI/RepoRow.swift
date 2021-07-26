//
//  ContentView.swift
//  GithubSearchUI
//
//  Created by Toseef on 7/26/21.
//

import SwiftUI

struct RepoRow: View {
    let repo: Repo
    
    var body: some View {
        
        NavigationLink(destination: RepoDetailView(repo: repo)) {
            VStack(alignment: .leading) {
                Text(repo.name)
                    .font(.headline)
                if let fullName = repo.fullName {
                    Text(fullName)
                        .font(.body)
                }
                if let url = repo.htmlUrl {
                    Button(action: {
                        
                    }, label: {
                        Text(url)
                            .font(.body)
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    })
                }
                Text(repo.description)
                    .font(.subheadline)
            }
        }
    }
}

struct RepoRow_Previews: PreviewProvider {
    static var previews: some View {
        RepoRow(repo: Repo(id: 1, name: "Swift", description: "Now we can start implementing view which represents Repo row in our list of repos.",fullName: "apple/swift",htmlUrl: "https://www.github.com/apple/swift"))

    }
}
