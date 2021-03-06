//
//  KoyaQuestApp.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/05/30.
//

import SwiftUI

@main
struct KoyaQuestApp: App {
    @StateObject var dataController: DataController
    @StateObject var appData = AppData()
    init() {
        let dataController = DataController()
        _dataController = StateObject(wrappedValue: dataController)
    }

    var body: some Scene {
        
        WindowGroup {
            ContentView()
                .environmentObject(AppData())
                .environmentObject(LocationManager())
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environmentObject(dataController)
                .statusBar(hidden: true)
                .onAppear { UIApplication.shared.isIdleTimerDisabled = true }
                .onDisappear { UIApplication.shared.isIdleTimerDisabled = false }
        }
    }
}
