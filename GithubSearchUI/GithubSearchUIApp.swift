//
//  GithubSearchUIApp.swift
//  GithubSearchUI
//
//  Created by Toseef on 7/26/21.
//

import SwiftUI

@main
struct GithubSearchUIApp: App {

    var body: some Scene {
        WindowGroup {
            SearchView().environmentObject(ReposStore(service: .init()))
        }
    }
}
