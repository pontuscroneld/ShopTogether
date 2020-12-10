//
//  Refresh.swift
//  ShopTogether2
//
//  Created by Pontus Croneld on 2020-12-09.
//

import SwiftUI

struct Refresh: View {
    var body: some View {
       
        ZStack{
            Capsule()
                .frame(width: 45, height: 45)
                .foregroundColor(.orange)
                .shadow(radius: 5)
            Image(systemName: "arrow.triangle.2.circlepath")
                .resizable()
                .foregroundColor(.white)
                .frame(width: 30, height: 25, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
        }
    }
}

struct Refresh_Previews: PreviewProvider {
    static var previews: some View {
        Refresh()
            .previewLayout(.sizeThatFits)
    }
}
