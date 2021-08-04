//
//  AboutGameView.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/06/04.
//

import SwiftUI

struct AboutGameView: View {
    @StateObject var viewModel = AboutGameViewModel()
    var body: some View {
            ZStack {
                Text("About Kōya Quest")
                    .font(.title)
                    .foregroundColor(.koyaOrange)
                    .bold()
                    .padding()
                List {
                    ForEach(viewModel.information) { info in
                        NavigationLink(
                            destination: AboutGameDetailView(contents: info)
                        ) {
                            HStack {
                                Image(systemName: "doc")
                                    .foregroundColor(.koyaDarkText)
                                Text(info.title)
                                .font(.headline)
                                    .foregroundColor(.koyaDarkText)
                            }
                        }
                    }
            }
                .onAppear {
                    viewModel.getInfo()
                }
                if viewModel.isLoading {
                    LoadingView()
                }
        }
    }
}

struct AboutGameView_Previews: PreviewProvider {
    static var previews: some View {
        AboutGameView()
    }
}
