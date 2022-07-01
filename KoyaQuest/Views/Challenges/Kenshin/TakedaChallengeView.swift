//
//  TakedaChallengeView.swift
//  KoyaQuest2021
//
//  Created by Kevin K Collins on 2021/05/03.
//

import SwiftUI

struct TakedaChallengeView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: KenshinChallengeViewModel
    @Binding var success: Bool
    var body: some View {
        ZStack {
            Color(.black)
                .ignoresSafeArea(.all)
            VStack {
                XDismissButtonRight()
                //Image(systemName: "barcode.viewfinder")
                if !viewModel.foundTakeda {
                    Text("Find the Tiger of Kai")
                    .font(.title)
                    .bold()
                    .foregroundColor(.koyaOrange)
                    .padding(.bottom, 6)

                    Text("Look for the nearby tomb...")
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)

                    TakedaScannerView(
                        scannedCode: $viewModel.scannedCode,
                        alertItem: $viewModel.alertItem,
                        foundLocation: $viewModel.foundLocation,
                        success: $viewModel.success,
                        foundTakeda: $viewModel.foundTakeda)
                        .frame(height: 380)
                        .padding(.bottom, 6)
                        .overlay(viewModel.displayOverlay ? BarcodeOverlayView() : nil)
                    Text("Scan the QR Code on the sign to confirm.")
                        .font(.callout)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.white)
                        .padding()
                       // .transition(.slide)
                    DirectionDistanceIndicator(
                        distance: viewModel.distanceToTarget,
                        rotation: viewModel.rotation,
                        color: viewModel.distanceIndicatorColor)
                } else {
                    Text("Congratulations!")
                        .font(.title)
                        .bold()
                        .foregroundColor(.koyaOrange)
                        .padding(.bottom, 6)
                    Text("You found the Grave of Takeda Shingen")
                        .font(.callout)
                        .foregroundColor(viewModel.scannerStatusTextColor)
                    Image("takeda shingen haka")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 300)
                        .padding(.bottom, 6)
                    KenshinSummaryView()
                        .padding(.bottom, 20)
                    Button {
                        success = true
                        viewModel.stopTakedaLocator()
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Got it!")
                            .font(.title3)
                            .bold()
                            .frame(
                                minWidth: 235,
                                idealWidth: 240,
                                maxWidth: 242, minHeight: 50,
                                idealHeight: 50, maxHeight: 50,
                                alignment: .center
                            )
                            .padding([.top, .bottom], 2 )
                            .padding([.leading, .trailing], 14 )
                            .background(Color.koyaGreen)
                            .foregroundColor(.white)
                    }
                }
                Spacer()
            }
        }
        .navigationBarTitle(Text(""))
        .navigationBarHidden(true)
        .statusBar(hidden: true)
        .alert(item: $viewModel.alertItem) { alertItem in
            Alert(title: Text(alertItem.title),
                  message: Text(alertItem.message),
                  dismissButton: alertItem.dismissButton)
        }
    }
}

struct TakedaChallengeView_Previews: PreviewProvider {
    static var previews: some View {
        TakedaChallengeView( viewModel: KenshinChallengeViewModel(), success: .constant(false))
    }
}

