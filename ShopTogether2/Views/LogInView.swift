//
//  LogInView.swift
//  ShopTogether2
//
//  Created by Pontus Croneld on 2020-12-05.
//

import SwiftUI
import FirebaseUI
import Firebase

struct LogInView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State var coordinator: AppleCoordinator?
    
    var body: some View {
        VStack{
            Text("Sign in to share your list with friends.")
            SignInWIthApple()
                .frame(width: 300, height: 45)
                .onTapGesture {
                    self.coordinator = AppleCoordinator()
                    if let coordinator = self.coordinator {
                        coordinator.startSignInWithAppleFlow {
                            print("You succesfully signed in")
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    }
                   
                } //End Tap Apple
     
            
        } // End top stack
        
        
    }// End body
    
    func LogIn(){
    }
    
}// End view

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}

