//
//  WelcomeView.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/05/31.

import SwiftUI
import CloudKit
import CoreData

struct WelcomeView: View {
    @EnvironmentObject var appData: AppData
    @Environment(\.managedObjectContext) var viewContext: NSManagedObjectContext
    @State private var isShowingInfo = false
    @Environment(\.sizeCategory) var sizeCategory: ContentSizeCategory
    var locationManager: LocationManager

    var body: some View {
        VStack {
            Spacer()
            TitleView(fullCaption: true)
            Button {
               // appData.gameStarted = true
               // appData.changeGameState(newState: .login)
                appData.changeGameState(newState: .active)
                locationManager.verifyGPSAuthorization()
            } label: {
            Text("Get Started".uppercased())
                .font(.title2)
                .bold()
                .padding(10)
                .frame(width: wideElement(sizeCategory: sizeCategory) ? 330 : 220, height: 50, alignment: .center)
                .border(Color.white)
                .foregroundColor(Color.white)
            }
            Spacer()
            Button {
                isShowingInfo = true
            } label: {
                HStack {
                    Text("More information".uppercased())
                        .font(.body)
                    Spacer()
                    Image(systemName: "info.circle" )
                }
                .padding(10)
                // swiftlint:disable:next colon
                 .frame(width: wideElement(sizeCategory: sizeCategory) ? 330 : 220, height: 50, alignment: .center)
               // .frame(width: 220, height: 50, alignment: .center)
                .background(Color.koyaSky)
                .border(Color(.white))
                .foregroundColor(Color(.black))

                .sheet(isPresented: $isShowingInfo, onDismiss: {}, content: {
                    WelcomeIntroView(isShowingInfo: $isShowingInfo )
                })
            }
            .padding(.bottom, 20)
        }
        .background(Image("mtns")
        .scaledToFill()
        .edgesIgnoringSafeArea([.all])
        )
        .animation(.easeInOut(duration: 0.8))
        }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView( locationManager: LocationManager())
    }
}
