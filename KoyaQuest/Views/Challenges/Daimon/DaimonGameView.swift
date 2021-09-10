//
//  DaimonGameView.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/06/05.
//

import SwiftUI
import SpriteKit

struct DaimonGameView: View {
    @EnvironmentObject var appData: AppData
    @Environment(\.presentationMode) var presentationMode
    @State private var selectionConfirmed = false
    @State private var isShowingMore = false
    @ObservedObject var viewModel: DaimonGameViewModel
    @Binding var gameOver: Bool
    @Binding var points: Int

    var scene: SKScene {
            let scene = DaimonGameScene()
            scene.size = CGSize(width: 400, height: 300)
            scene.scaleMode = .aspectFit
            scene.backgroundColor = UIColor(.clear)
            scene.viewModel = viewModel
            return scene
        }

    var body: some View {
        ZStack {
            BackgroundView()
                .ignoresSafeArea()
            VStack {
                XDismissButtonRight()
                    .padding(.top, 4)
                    .padding(.trailing, 12)
                Spacer()
                    .frame(height: 40)
                Text("Provide your Answer")
                    .foregroundColor(.koyaOrange)
                    .font(.title)
                    .bold()
                SpriteView(scene: scene)
                    .frame(width: 400, height: 300)
                    // .overlay(OverlayGridView())
                Group {
                    if !selectionConfirmed {
                    HStack {
                        Image(systemName: "hand.tap")
                            .font(.title3)
                        Text("Tap the Section")
                            .font(.title3)
                            .bold()
                    }
                    .foregroundColor(.koyaOrange)
                    .padding(.bottom, 6)
                    Text("Tap on the area within the picture that you believe differs from the actual Daimon.")
                        .font(.body)
                        .foregroundColor(.white)
                        .italic()
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 4)
                        // swiftlint:disable:next line_length
                    Text("Remember: it will be part of the actual gate.\n(And it will be obvious; when you find it, you'll knowit!)")
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .italic()
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 10)
                    } else {
                        Text(viewModel.tapOnTarget ? "Success!" : "Too bad")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(viewModel.tapOnTarget ? Color.koyaGreen : Color.koyaRed)
                            .padding()
                        Button {
                            handleGameOver(points: points)
                            self.presentationMode.wrappedValue.dismiss()
                        } label: {
                            ActionButton(color: Color.koyaOrange, text: "Got it")
                        }
                        .buttonStyle(ScaleButtonStyle())

                        Button {
                            isShowingMore.toggle()
                        } label: {
                            HStack {
                                Image(systemName: "book.fill")
                                Text("Click to Learn More")
                            }
                            .font(.caption)
                            .foregroundColor(.koyaOrange)
                            .padding()
                        }
                    }
                }
                Spacer()
                }
            }
        .navigationTitle("")
        .navigationBarHidden(true)
                .alert(isPresented: $viewModel.showingAlert) {
                    Alert(
                            title: Text("Confirm your Selection"),
                            message: Text("Are you sure this is where the difference is?"),
                            primaryButton: .default (Text("Yes")) {
                                print("user is sure")
                                selectionConfirmed = true
                                viewModel.showingSolution = true
                            },
                            secondaryButton: .destructive (
                                Text("No (try again)"))
                            )
                } // end alert is presented
        .sheet(isPresented: $isShowingMore, content: {
            DaimonLearnMoreView(isShowingMore: $isShowingMore)
        })
        }

    func handleGameOver(points: Int) {
            viewModel.isShowingModal = true
            gameOver = true
        }
    }

struct DaimonGameView_Previews: PreviewProvider {
    static var previews: some View {
            DaimonGameView(
                viewModel: DaimonGameViewModel(),
                gameOver: .constant(true),
                points: .constant(0)
            )
            .preferredColorScheme(.light)
    }

}
