//
//  BonusQuestionView.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/06/18.
//

import SwiftUI

struct MCButtonStyle: ButtonStyle {
    let color: Color
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 190, height: 20, alignment: .center)
            .padding(.vertical)
            .padding(.horizontal, 30)
            .background(color)
            .foregroundColor(.white)
            .overlay(
                Color(.black)
                    .opacity(configuration.isPressed ? 0.3 : 0)
            )
    }
}

struct BonusQuestionView: View {
    @Environment(\.sizeCategory) var sizeCategory: ContentSizeCategory
    var question: Bonus
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var appData: AppData
    @StateObject var viewModel = BonusQuestionViewModel()
    @State private var isShowingModal = false
    @State var firstChoiceIsShowing = true
    @State var secondChoiceIsShowing = true
    @State var thirdChoiceIsShowing = true
    @State var fourthChoiceIsShowing = true
    @State var correct = false

    var body: some View {
        ZStack {
            BackgroundView()
                .ignoresSafeArea(.all)
            VStack {
                Text("Multiple-Choice Question")
                    .font(wideElement(sizeCategory: sizeCategory) ? .caption2 : .title)
                    .foregroundColor(.white)
                    .padding(.bottom)
                HStack {
                    Image(systemName: "exclamationmark.bubble")
                        .font(.title2)
                        .foregroundColor(Color.koyaOrange)
                    Text("Keep going until you get the correct answer!")
                        .font(.callout)
                        .foregroundColor(.white)
                        .italic()
                }

                Divider()
                    .background(Color.white)
                    .padding([.bottom, .leading, .trailing], 2)

                        Text(question.question)
                            .foregroundColor(Color.white)
                            .multilineTextAlignment(.leading)
                            .font(wideElement(sizeCategory: sizeCategory) ? .caption2 : .title3)
                            .padding(20)

                        if firstChoiceIsShowing {
                            showChoice(for: question.choices[0], tag: 0)
                                .buttonStyle(MCButtonStyle(color: Color.koyaOrange))
                        } else {
                            showDisabledButton(for: question.choices[0], tag: 0)
                                .disabled(true)
                                .buttonStyle(MCButtonStyle(color: .gray))
                        }

                        if secondChoiceIsShowing {
                            showChoice(for: question.choices[1], tag: 1)
                                .buttonStyle(MCButtonStyle(color: Color.koyaOrange))
                        } else {
                            showDisabledButton(for: question.choices[1], tag: 1)
                                .disabled(true)
                                .buttonStyle(MCButtonStyle(color: .gray))
                        }

                        if thirdChoiceIsShowing {
                            showChoice(for: question.choices[2], tag: 2)
                                .buttonStyle(MCButtonStyle(color: Color.koyaOrange))
                        } else {
                            showDisabledButton(for: question.choices[2], tag: 2)
                                .disabled(true)
                                .buttonStyle(MCButtonStyle(color: .gray))
                        }

                        if fourthChoiceIsShowing {
                            showChoice(for: question.choices[3], tag: 3)
                                .buttonStyle(MCButtonStyle(color: Color.koyaOrange))
                        } else {
                            showDisabledButton(for: question.choices[3], tag: 3)
                                .disabled(true)
                                .buttonStyle(MCButtonStyle(color: .gray))
                        }
                Spacer()
                }
            .blur(radius: isShowingModal ? 6 : 0)
            if isShowingModal {
                BonusFeedbackView(
                    appData: appData,
                    bonus: question,
                    points: viewModel.points,
                    success: true)
            }
        }
    }

    func showChoice(for choice: Answers, tag: Int) -> some View {

         Button {
             if choice.correct {
                viewModel.calculateScore()
                isShowingModal = true
             } else {
                 viewModel.count += 1
                 hideChoice(tag: tag)
             }
         } label: {
             HStack {
                 Image(systemName: "square")
                 Spacer()
                 Text(choice.text)
                    .font(wideElement(sizeCategory: sizeCategory) ? .caption2 : .body)
                 Spacer()

             }
         }
         .padding(.bottom, 6)
    }

        func showDisabledButton(for choice: Answers, tag: Int ) -> some View {
            Button {
                // no action yet
            } label: {
                HStack {
                    Image(systemName: "xmark.square")
                    Spacer()
                    Text(choice.text)
                    Spacer()
                }
        }
        .padding(.bottom, 6)
    }

    func hideChoice(tag: Int) {
        switch tag {
        case 0:
            firstChoiceIsShowing = false
        case 1:
            secondChoiceIsShowing = false
        case 2:
            thirdChoiceIsShowing = false
        case 3:
            fourthChoiceIsShowing = false
        default:
            return
        }
    }
}

struct BonusQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        BonusQuestionView(question: Bonus.shogunBonus, appData: AppData())
    }
}
