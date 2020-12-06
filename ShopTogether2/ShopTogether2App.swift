//
//  ShopTogether2App.swift
//  ShopTogether2
//
//  Created by Pontus Croneld on 2020-12-05.
//

import SwiftUI
import Firebase

@main
struct ShopTogether2App: App {
    
    init(){
        
        FirebaseApp.configure()
        if Auth.auth().currentUser == nil {
            Auth.auth().signInAnonymously()
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
