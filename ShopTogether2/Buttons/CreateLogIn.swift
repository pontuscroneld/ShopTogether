//
//  CreateLogIn.swift
//  ShopTogether2
//
//  Created by Pontus Croneld on 2020-12-09.
//

import SwiftUI
import Firebase

struct CreateLogIn: View {
    
   
    var action: String
    var buttoncolor: Color
    var function: String
    var newEmail: String
    var newPassword: String
    
    
    var body: some View {
        Button(action:{
            
            if function == "create"{
                createNewEmail()
            }
            if function == "login" {
                logInEmail()
            }
            
            else {
                return
            }
            
        }
        ) {
            Text(action)
                .font(.headline)
                .fontWeight(.regular)
        }
        .frame(width: 150, height: 50)
        .background(buttoncolor)
        .cornerRadius(7)
        .foregroundColor(.white)
        
    }
    
    func createNewEmail()  {
        
        Auth.auth().createUser(withEmail: newEmail, password: newPassword) { authResult, error in
            if(error == nil)
            {
                // LOGIN OK!
                print("Sign up ok")
                
              
            } else {
                print("Sign up error")
                
            
            }
        }
    }

    func logInEmail(){
        
        Auth.auth().signIn(withEmail: newEmail, password: newPassword) { authResult, error in
            if(error == nil)
            {
                // LOGIN OK!
                print("Login ok")
                
            } else {
                print("Login error")
            }
        }
    }
}

struct CreateLogIn_Previews: PreviewProvider {
    static var previews: some View {
        CreateLogIn(action: "Create User", buttoncolor: .red, function: "create", newEmail: "test@test.se", newPassword: "abc")
            .previewLayout(.sizeThatFits)
    }
}
