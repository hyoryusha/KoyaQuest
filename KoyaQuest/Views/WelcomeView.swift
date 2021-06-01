//
//  WelcomeView.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/05/31.
//

import SwiftUI

struct WelcomeView: View {
    @EnvironmentObject var appData: AppData
    @State private var isShowingInfo = false
    var locationManager : LocationManager
    
    var body: some View {
        VStack {
            Spacer()
            TitleView(fullCaption: true)
            
            Button(action:{
                appData.gameStarted = true
                locationManager.verifyGPSAuthorization()
            }) {
            Text("Get Started".uppercased())
                .font(.title2)
                .bold()
                .padding(10)
                .frame(width: 220, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .border(Color.white)
                .foregroundColor(Color.white)
            }
            Spacer()
            Button(action:{
                isShowingInfo = true
            }) {
                HStack{
                    Text("More information".uppercased())
                        .font(.body)
                    Spacer()
                    Image(systemName: "info.circle" )
                }
                .padding(10)
                .frame(width: 220, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .background(Color("LightBlue"))
                .border(Color(.white))
                .foregroundColor(Color(.black))
                
                .sheet(isPresented: $isShowingInfo, onDismiss: {} , content: {
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
