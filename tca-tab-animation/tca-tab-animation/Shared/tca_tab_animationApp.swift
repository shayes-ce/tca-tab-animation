//
//  tca_tab_animationApp.swift
//  tca-tab-animation
//
//  Created by Steven Hayes on 1/29/24.
//

import SwiftUI

@main
struct tca_tab_animationApp: App {
    var body: some Scene {
        WindowGroup {
            AppView(
                store: .init(initialState: AppFeature.State()) {
                    AppFeature()
                }
            )
        }
    }
}
