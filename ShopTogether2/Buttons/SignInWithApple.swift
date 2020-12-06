//
//  SignInWithApple.swift
//  ShopTogether2
//
//  Created by Pontus Croneld on 2020-12-05.
//


import Foundation
import SwiftUI
import AuthenticationServices

struct SignInWIthApple: UIViewRepresentable {
    
    
    
    func makeUIView(context: Context) -> ASAuthorizationAppleIDButton {
        return ASAuthorizationAppleIDButton(type: .signIn, style: .black)
    }
    
    func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: Context) {
        
    }
    
}
