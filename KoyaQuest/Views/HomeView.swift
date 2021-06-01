//
//  HomeView.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/05/30.
//THIS FILE IS JUST FOR TESTING DATA AT SET UP

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var dataController: DataController

    var body: some View {
        NavigationView {
            VStack {
                Button("Add Data") {
                    dataController.deleteAll()
                    try? dataController.createSampleData()
                }
            }
            .navigationTitle("Home")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
