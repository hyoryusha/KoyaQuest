//
//  ShareScoreSummary.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2022/05/15.
//

import SwiftUI

struct ShareScoreSummary: View {
    @EnvironmentObject var appData: AppData
    @Environment(\.sizeCategory) var sizeCategory: ContentSizeCategory
    @Environment(\.presentationMode) var presentationMode
    @State var shareScreen: Bool = false
    
    var deviceWidth: CGFloat {
        UIScreen.main.bounds.width
    }

    var deviceHeight: CGFloat {
        UIScreen.main.bounds.height
    }
    
    var shareView: some View {
        ZStack {
            Image("sharing")
                .resizable()
                .scaledToFit()
            VStack {
                Text("Score:")
                    .font(.body)
                    .foregroundColor(.white)
                Text("\(appData.totalScore)")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)
                Text("Earning a rank of")
                    .font(.body)
                    .foregroundColor(.white)
                Text("\(appData.level.rawValue)")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)
            }
            .padding(.top, 40)
        }
        .frame(width: deviceWidth * 0.9)
    }
    
    var body: some View {
            VStack {
                ScoreSummaryTopView()
                //Spacer()
                Text("Share your achievement!")
                    .font(.title)
                    .italic()
                    .bold()
                    .foregroundColor(Color.koyaPurple)
                    .padding(.top, 80)
                Text("Post the following summary to selected social media.")
                    .font(.subheadline)
                    .foregroundColor(.koyaPurple)
                    .padding(.top, 8)

                shareView
                    .shadow(color: .koyaPurple, radius: 10, x: 10, y: 10)
                Button {
                    appData.imageToShare = shareView.snapshot()
                    shareScreen.toggle()
                } label: {
                    HStack {
                        Image(systemName: "square.and.arrow.up")
                        Text("Click to share".uppercased())
                            .font(.title3)
                            .bold()
                            
                    }
                    .padding(10)
                    .frame(width: wideElement(sizeCategory: sizeCategory) ? 330 : 220, height: 50, alignment: .center)
                    .border(Color.white)
                    .foregroundColor(Color.white)
                    //.foregroundColor(.koyaPurple)
                }
                .buttonStyle(ScaleButtonStyle())
                .padding(.bottom, 20)
                .padding()
                Spacer()
            }
            .padding(2)
            .navigationBarTitle(Text(""))
            .navigationBarHidden(true)
            .statusBar(hidden: true)
            .background(Image("mtns")
                            .scaledToFill()
                            .edgesIgnoringSafeArea([.all]))
            .sheet(isPresented: $shareScreen) {
                Share(imageToShare: appData.imageToShare)
                    }
    }
    
}

struct ShareScoreSummary_Previews: PreviewProvider {
    static var previews: some View {
        ShareScoreSummary()
            .environmentObject(AppData())
    }
}
