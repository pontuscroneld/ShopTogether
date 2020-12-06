//
//  HomeView.swift
//  ShopTogether2
//
//  Created by Pontus Croneld on 2020-12-05.
//

import SwiftUI
import Firebase

struct CircleImage: View {
    
    
    
    var image: Image
    var borderColor: Color = .white
    var shadowRadius: CGFloat = 10
    var circlewidth: CGFloat?
    var circleheight: CGFloat?
 
    var body: some View {
        image
            .clipShape(Circle())
            .overlay(Circle().stroke(borderColor, lineWidth: 4))
            .shadow(radius: shadowRadius)
            .frame(width: circlewidth, height: circleheight)
    }
}

struct HomeView: View {
    
    @State private var isActive : Bool = false
    @State var ShowSignIn = false
    @State var sidemenu = false
    
    var body: some View {
        
        
                
            
            
            ZStack {
               
                VStack {
                    
                    
                        
                        HStack{
                            Button(action: {
                                sidemenu.toggle()
                                print("Pressed side menu")
                            }, label: {
                                Image(systemName: "line.horizontal.3")
                            }).padding()
                            Spacer()
                        }
                        
                        NavigationLink(
                            destination: ContentView(),
                            isActive: self.$isActive){
                            Text("")
                        }
                            
                            Button(action: {
                                self.isActive = true
                            }) {
                                Text("Go to List")
                                    
                                    .font(.largeTitle)
                                Image(systemName: "arrow.right")
                                    
                                
                            }.padding().accentColor(/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/)
                        //Knapp för övergång.
                        Spacer()
                        
                        CircleImage(image: Image("fruits").resizable(),
                                    
                                    borderColor: .white,
                                    shadowRadius: 10, circlewidth: 200,
                                    circleheight: 200)
                            
                            
                            
                            Spacer()
                        
        
                        
                        
                        .sheet(isPresented: $ShowSignIn, content: {
                           LogInView()
                        })
                        
                }//Top VStack
                
                if sidemenu {
                    
                    HStack {
                        VStack {
                        
                        List{
                            Button(action: { sidemenu.toggle()
                                
                            }) {
                                Image(systemName: "line.horizontal.3")
                            }
                            
                            
                            
                            Button(action: {
                                
                            }) {
                                Text("Profile")
                            }
                            Button(action: {
                                
                            }) {
                                Text("Share")
                            }
                            Button(action: {
                                
                            }) {
                                Text("Settings")
                                
                            }
                            
                            Spacer(minLength: 450)
                            
                            
                            Button(action: {
                                
                                
                            }, label: {
                                HStack{
                                    Text("Log out")
                                    Image(systemName: "lock.circle")
                                }
                            })
                            
                        }.listStyle(SidebarListStyle())
                        
                        Spacer()
                    }.frame(width: 150, height: 860)
                        .background(Color.green)
                        Spacer()
                    }
                    
                    
                
               
                }
            } // Top ZStack
        //} // Nav
    } // Body
} // Struct

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

