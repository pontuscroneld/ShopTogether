//
//  SignOut.swift
//  ShopTogether2
//
//  Created by Pontus Croneld on 2020-12-09.
//

import SwiftUI
import Firebase

struct SignOut: View {
    
    var body: some View {
        
        VStack {
            
            
            Button(action: {
                
                let firebaseAuth = Auth.auth()
            do {
              try firebaseAuth.signOut()
            } catch let signOutError as NSError {
              print ("ERROR ERROR ERROR ERROR ERROR ERROR", signOutError)
            }
              
                print("Succesfully signed out")
                
            }, label: {
                
                HStack{
                    Image(systemName: "signpost.left")
                    Text("Sign out")
                }
                
                
            }).frame(width: 300, height: 45)
            .background(Color.red)
            .cornerRadius(7)
            .foregroundColor(.white)
            .font(.headline)
            
        }
    }
}

struct SignOut_Previews: PreviewProvider {
    static var previews: some View {
        SignOut()
            .previewLayout(.sizeThatFits)
    }
}
