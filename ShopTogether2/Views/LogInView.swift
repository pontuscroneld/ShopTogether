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
    
    @State var logInWithEmail = false
    @State var email = ""
    @State var password = ""
   
    
    @Environment(\.presentationMode) var presentationMode
    @State var coordinator: AppleCoordinator?
    
    var body: some View {
        VStack{
            
            NavigationLink(
                destination: EmailView(),
                isActive: $logInWithEmail,
                label: {
                    Text("")
                })
            
            Spacer()
            
            Image("basket.logo")
                .resizable()
                .frame(width: 300, height: 70, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .padding(.bottom, 50)
            
           
            
            if(logInWithEmail == false){
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
            }
           //SignInWithEmail()
            
            Button(action: {
                logInWithEmail.toggle()
                
            }) {
                SignInWithEmail()
                //Text("Email")
            }
            
            if(logInWithEmail == true){
                
                TextField("Email adress", text: $email)
                    .padding()
                SecureField("Password", text: $password)
                    .padding()
                
                HStack{
                    CreateLogIn(action: "Create User", buttoncolor: .orange, function: "create", newEmail: email, newPassword: password) 
                    CreateLogIn(action: "Log in", buttoncolor: .green, function: "login", newEmail: email, newPassword: password)
                }
                
            }

            SignOut().padding(.top, 2)
                .onTapGesture {
                    presentationMode.wrappedValue.dismiss()
                }
        
            
            Text("Share basket with your household using the same login!")
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
                .frame(width: 200, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .padding()
                .font(.caption)
        
            Spacer()
            
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

