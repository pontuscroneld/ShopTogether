//
//  SignInWithEmail.swift
//  ShopTogether2
//
//  Created by Pontus Croneld on 2020-12-09.
//

import SwiftUI

struct SignInWithEmail: View {
    
    @State var goEmail = false
    
    var body: some View {
        
        VStack {
            
            
            Button(action: {
                
                
                print("Button pressed")
                
            }, label: {
                
                HStack{
                    Image(systemName: "envelope")
                    Text("Sign in with Email")
                }
                
                
            }).frame(width: 300, height: 45)
            .background(Color.green)
            .cornerRadius(7)
            .foregroundColor(.white)
            .font(.headline)
            
        }
    }
}

struct SignInWithEmail_Previews: PreviewProvider {
    static var previews: some View {
        SignInWithEmail()
            .previewLayout(.sizeThatFits)
    }
}
