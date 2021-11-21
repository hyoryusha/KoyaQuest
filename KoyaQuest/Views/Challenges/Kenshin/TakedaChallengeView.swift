//
//  TakedaChallengeView.swift
//  KoyaQuest2021
//
//  Created by Kevin K Collins on 2021/05/03.
//

import SwiftUI

struct TakedaChallengeView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel = KenshinChallengeViewModel()
    @Binding var success: Bool
    var body: some View {
        ZStack {
            Color(.black)
                .ignoresSafeArea(.all)
            VStack {
                XDismissButtonRight()
                HStack {
                    Image(systemName: "barcode.viewfinder")
                    Text("Find the Tiger of Kai")
                }
                .font(.title)
                .foregroundColor(.orange)
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
                // Rectangle()
                    .frame(height: 380)
                    .padding(.bottom, 6)

                if viewModel.foundTakeda {
                    Text("Congratulations! You found:")
                        .font(.body)
                        .foregroundColor(viewModel.scannerStatusTextColor)
                    Text(viewModel.foundLocation)
                        .font(.headline)
                        .foregroundColor(viewModel.scannerStatusTextColor)
                    Button {
                        success = true
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
                } else {
                    Text("When you think you have found it, scan the QR Code on the nearby sign to confirm.")
                        .font(.callout)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.white)
                        .padding()
                    Text(viewModel.foundLocation)
                        .font(.body)
                        .foregroundColor(Color.koyaOrange)
                        .transition(.slide)
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
        TakedaChallengeView( success: .constant(false))
    }
}
