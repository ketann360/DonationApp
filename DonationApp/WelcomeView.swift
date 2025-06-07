//
//  WelcomeView.swift
//  DonationApp
//
//  Created by Meet Patel on 6/1/25.
//

import SwiftUI

struct WelcomeView: View {
    var onDonateNow: () -> Void
    @State private var isGlowing = false
    
    var body: some View {
        VStack(spacing:40){            
            //Temple logo placeholder
            Image("kalupur_mandir_logo").resizable()
                .frame(width:380,height:220)
            Text("Shree Swaminarayan Temple (ISSO)")
                .font(.largeTitle)
                .foregroundColor(.white)
            
            
            //Temple logo placeholder
//            RoundedRectangle(cornerRadius: 12)
//                .strokeBorder(Color.gray,lineWidth: 2)
//                .frame(width:120,height:120)
//                .overlay(Text("Logo").foregroundColor(.gray))
            
            
            // Donate Button
            Button(action:{
                onDonateNow()
            }){
                Text("Donate Now")
                    .frame(width: 260, height: 60)
                    .foregroundColor(.white)
                    .font(.title)
                    .background(Color.blue)
                    .cornerRadius(15)
                    .shadow(color: Color.white.opacity(0.8), radius: isGlowing ? 20 : 5)
                                    //.scaleEffect(isGlowing ? 1.05 : 1.0)
                    .animation(.easeInOut(duration: 3).repeatForever(autoreverses: true), value: isGlowing)
            }
            .padding()
            .onAppear(){
                isGlowing = true
            }
        }
    }
}

#Preview {
    WelcomeView(onDonateNow: {
        print("success")
    })
}
