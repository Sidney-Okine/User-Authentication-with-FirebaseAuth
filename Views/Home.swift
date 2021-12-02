//
//  Home.swift
//  Home
//
//  Created by Mister Okine on 25/07/2021.
//

import SwiftUI
import Firebase

struct Home: View {
    @State var show = false
    @AppStorage("log_Status") var status = false

    var body: some View {
        ZStack{
            
            VStack{
            
                HStack{
                
                    Text("You're Welcome Home")
                        .font(.system(size: 25))
                        .fontWeight(.light)
                        .foregroundColor(.black)
                    
                    LottieView(name: "emoji-wink", loopMode: .loop)
                        .frame(width: 50, height: 50)
                
                }
                LottieView(name: "home-location", loopMode: .loop)
                    .frame(width: UIScreen.main.bounds.width-200, height: 200, alignment: .center)
                    .padding(.top,100)
            
                

            }
            VStack(alignment: .center, spacing: 12){
                if self.show {
                    PopOver()
                        .clipShape(ArrowShape())
                        .cornerRadius(15)
                }
            
                Button(action: {
            
                    withAnimation(.spring()){
                        self.show.toggle()
                    }
                    
                }) {
                    
                    Image(systemName: self.show ? "xmark" : "hand.point.up.braille")
                        .resizable()
                        .frame(width: 20, height: 22)
                        .padding()
                }
                .background(.thinMaterial)
                .background(Color.red)
                .clipShape(Circle())
                
                .offset(y: 15)
            }
            .frame(width: UIScreen.main.bounds.width-40, height: UIScreen.main.bounds.height-60, alignment: .bottomTrailing)
            .padding()
        
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

struct PopOver : View {
    @AppStorage("log_Status") var status = false
    

    var body: some View{
        VStack(alignment: .leading, spacing: 10) {
            
            Button(action: {

    
                try? Auth.auth().signOut()
                withAnimation{status = false}

            }){
                HStack(spacing: 10){
                    Text("Log Out")
                        .fontWeight(.light)
                    LottieView(name: "log-out", loopMode: .loop)
                        .frame(width: 50, height: 52, alignment: .center)
                }
            }
        }
        .frame(width: 140)
        .padding(.bottom)
    }
}

struct ArrowShape: Shape {
    func path(in rect: CGRect) -> Path {
        return Path{ path in
            let center = rect.width / 2
                
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height-20))


            path.addLine(to: CGPoint(x: center - 15, y: rect.height - 20))
            path.addLine(to: CGPoint(x: center, y: rect.height - 5))
            path.addLine(to: CGPoint(x: center + 15, y: rect.height - 20))

            path.addLine(to: CGPoint(x: 0, y: rect.height - 20))

        }
    }

}
