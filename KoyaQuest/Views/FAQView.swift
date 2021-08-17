//
//  HomeView.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/05/30.
// THIS FILE IS JUST FOR TESTING DATA AT SET UP

import SwiftUI

struct FAQView: View {
    @StateObject var viewModel = FAQViewModel()

    var body: some View {
            ZStack {
                Text("Mt. Kōya FAQ")
                    .font(.title)
                    .foregroundColor(.koyaOrange)
                    .bold()
                    .padding()
                List {
                    ForEach(viewModel.faq) { faq in
                        NavigationLink(
                            destination: FAQDetailView(contents: faq)
                        ) {
                            HStack {
                                Image(systemName: "questionmark.circle")
                                    .foregroundColor(.koyaDarkText)
                                Text(faq.title)
                                .font(.headline)
                                    .foregroundColor(.koyaDarkText)
                            }
                        }
                    }
                    .alert(item: $viewModel.alertItem) { alertItem in
                        Alert(title: alertItem.title,
                              message: alertItem.message,
                              dismissButton: alertItem.dismissButton)
                    }
            }
                .onAppear {
                    viewModel.getFAQ()
                }
                if viewModel.isLoading {
                    LoadingView()
                    Spacer()
                }
        }
            .statusBar(hidden: true)
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        FAQView()
    }
}
