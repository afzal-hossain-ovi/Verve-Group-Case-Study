//
//  Verve_Group__Case_Study_App.swift
//  Verve Group (Case Study)
//
//  Created by Afzal Hossain on 02.06.22.
//

import SwiftUI

@main
struct VerveGroupCaseStudyApp: App {
    private let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            NavigationView {
                ProjectListView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
            .navigationViewStyle(.stack)
        }
    }
}
