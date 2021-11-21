//
//  BonusListView.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/06/18.
//

import SwiftUI
struct BonusListView: View {
    @EnvironmentObject var appData: AppData
    var body: some View {
        List {
            ForEach(Bonus.bonusQuestions) { question in
                NavigationLink(
                    destination: BonusQuestionView(
                        question: question,
                        appData: appData)
                ) {
                    BonusListViewRow(
                        question: question,
                        state: bonusState(bonus: question)
                    )
                }
                .navigationTitle(
                    Text("Bonus Questions")).disabled(isLocked(
                        bonus: question)
                    )
            }
        }
        .navigationTitle("Bonus Questions")

    }

    func bonusState(bonus: Bonus) -> BonusState {
        var state: BonusState = .locked
        if appData.completedBonusSummary.contains( where: {$0.id == bonus.id }) {
            state = .completed
        } else {
            if appData.activeBonus == bonus {
                state = .active
            }
        }
        return state
    }

    func isLocked(bonus: Bonus) -> Bool {
        if bonusState(bonus: bonus) == .completed || bonusState(bonus: bonus) == .locked {
            return true
        } else {
            return false
        }
    }

    struct BonusQuestionList_Previews: PreviewProvider {
        static var previews: some View {
            BonusListView()
                .environmentObject(AppData())
        }
    }
}

struct BonusListViewRow: View {
    var question: Bonus
    var state: BonusState
    var body: some View {

        HStack {
            BonusIconView(state: state)
            VStack(alignment: .leading) {
                Text("Bonus No. \(question.id)")
                    .font(.title)
                Text(getSubText(state: state))
                    .foregroundColor(.secondary)
            }
            .padding(.leading, 6)
        }
        .padding()
    }

    func getSubText(state: BonusState) -> String {
        var blurb: String = ""
        switch state {
        case .completed:
            blurb = "Completed"
        case .locked:
            blurb = "Unavailable"
        case .active:
            blurb = "CLICK HERE"
        }
        return blurb
    }

}

struct BonusIconView: View {
    var state: BonusState
    var body: some View {
        switch state {
        case .completed:
            Image(systemName: "checkmark.circle.fill")
                .font(.largeTitle)
                .foregroundColor(.koyaGreen)
        case .active:
            Image(systemName: "lock.open")
                .font(.largeTitle)
                .foregroundColor(.koyaGreen)
        case .locked:
            Image(systemName: "lock.slash")
                .font(.largeTitle)
                .foregroundColor(.koyaOrange)
        }
    }
}
