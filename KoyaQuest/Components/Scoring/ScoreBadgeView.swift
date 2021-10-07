//
//  ScoreBadgeView.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/09/25.
//

import SwiftUI

struct ScoreBadgeView: View {
    var challenge: String
    var complete: Bool = false
    var points: Int

    var body: some View {
            HStack{
//                Text(challenge)
//                    .font(.caption)
//                    .bold()
//                    .foregroundColor(.koyaOrange)
//                Image(complete ? "lantern" : "lantern_gray")
//                    .resizable()
//                    .frame(width: 50, height: 50)
//                    //.foregroundColor(.white)
//                    .padding(6)
//                    .background(complete ? Color.green : Color.koyaPurple)
//                    .clipShape(Circle())
//
//                    //.shadow(color: .gray, radius: 14 , x: 8, y: 8)
//                Text(complete ? "\(points) Points" : "Incomplete")
//                    .font(.subheadline)
//                    .foregroundColor(complete ? .koyaGreen : .gray)
                Image(complete ? "completed_challenge_icon" : "incompleted_challenge_icon_purple")
                                    .resizable()
                                    .frame(width: 122, height: 122)
                    .clipShape(RoundedRectangle(cornerRadius: 6.0))

                                    //.foregroundColor(.white)
                                    .padding(6)

                    .overlay(ScoreBadgeOverlay(challenge: challenge, points: points, complete: complete))

                    .overlay(complete ? ScoreBadgeCheckMarkOverlay() : nil)

            }
    }
}

struct ScoreBadgeOverlay: View {
    var challenge: String
    var points: Int
    var complete: Bool
        var body: some View {
            Spacer()
            ZStack {

                VStack{
                    Spacer()
                    HStack {
                        VStack(alignment: .leading)  {
                            Text(challenge)
                                .font(.caption2)
                                .bold()
                                .shadow(color: Color.black, radius: 3, x: 3, y: 3)
                                .padding(.bottom, 2)
                                //.frame(width: 90, height: 40, alignment: .leading)
                            Text(complete ? "\(points) Points" : "")
                                .font(.body)
                                .bold()
                                .shadow(color: Color.black, radius: 3, x: 3, y: 3)
                                //.frame(width: 90, height: 40, alignment: .leading)
                                .padding(.bottom, 0)
                        }
                        .padding(.leading, 9)
                        .padding(.bottom, 12)
                        Spacer()
                    }

                    }
                //}

            }
            .foregroundColor(.white)
        }
    }

struct ScoreBadgeCheckMarkOverlay: View {
    var body: some View {
        ZStack(alignment: .topTrailing) {
            HStack{
                Spacer()
                VStack(alignment: .trailing) {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.koyaGreen)
                        .font(.title)
                        .offset(x: 2, y: -2)
                    Spacer()
                }
            }
        }
    }
}

struct ScoreBadgeView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreBadgeView(challenge: mizumukeChallenge.name, complete: true, points: 20)
    }
}

