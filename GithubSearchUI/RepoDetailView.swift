//
//  RepoDetailView.swift
//  GithubSearchUI
//
//  Created by Toseef on 7/26/21.
//

import SwiftUI

struct RepoDetailView: View {
    let repo: Repo
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            ScrollView {
            VStack {

                Image(systemName: "archivebox.circle.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                Text(repo.name)
                    .font(.title)
                    .foregroundColor(.pink)

                Text(repo.fullName ?? "")
                    .font(.title3)
                    .foregroundColor(.gray)

                Divider()
                HStack (spacing: 30){
                    RDButton(text: "Fork", imageName: "arrow.triangle.branch", imgColor: Color.pink)

                    RDButton(text: "Save", imageName: "star.fill", imgColor: Color.orange)


                    RDButton(text: "Share", imageName: "square.and.arrow.up")


                    RDButton(text: "Flag", imageName: "flag.fill", imgColor: Color.red)

                }.padding(8)

                Divider()
                HStack() {
                    Image(systemName: "doc.fill")
                        .foregroundColor(.gray)
                    Text("Description")
                        .font(.title3)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.gray)
                    Spacer()
                }
                .padding(8)


                Text(repo.description)
                    .font(.title3)
                    .foregroundColor(.gray)
                Spacer()

            }
            .padding(8)
            }
        }.navigationTitle(repo.name)
    }
}

struct RepoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let repo = Repo(id: 1, name: "Github Search", description: "Now we can start implementing view which represents Repo row in our list of repos.",fullName: "FullName",htmlUrl: " html url")
        RepoDetailView(repo: repo)
    }
}


struct RDButton: View {

    let text: String
    let imageName: String
    var imgColor: Color = .accentColor

    var body: some View {
        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
            VStack{
                Image(systemName: imageName)
                    .foregroundColor(imgColor)
                Text(text)
            }
        })
        .frame(width: 50, height: 50)
        .foregroundColor(.black)
        .padding(8)
        .background(Color.init(white: 0.925))
        .cornerRadius(30)
    }
}
