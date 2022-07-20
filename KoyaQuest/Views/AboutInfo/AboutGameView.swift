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
                            destination: AboutKoyaQuestView(contents: info)
                        ) {
                            HStack {
                                Image(systemName: getIcon(id: info.id))
                                    .font(.title2)
                                    .foregroundColor(.koyaOrange)
                                Text(info.title)
                                    .font(.headline)
                                    .bold()
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

    func getIcon(id: Int) -> String {
        var icon: String = "doc"
        switch id {
        case 1001:
            icon = "questionmark.diamond"
        case 1002:
            icon = "target"
        case 1003:
            icon = "scope"
        case 1004:
            icon = "puzzlepiece"
        case 1005:
            icon = "iphone.radiowaves.left.and.right"
        case 1006:
            icon = "map"
        case 1007:
            icon = "hands.sparkles"
        default:
            icon = "doc"
        }
        return icon
    }
}

struct AboutGameView_Previews: PreviewProvider {
    static var previews: some View {
        AboutGameView()
            .preferredColorScheme(.dark)
    }
}
