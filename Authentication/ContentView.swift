//  ContentView.swift
//  Authentication
//
//  Created by Mister Okine on 23/07/2021.

import SwiftUI

struct ContentView: View {
    @AppStorage("log_Status") var status = false

    var body: some View {
        ZStack{
            if status{
                
                Home()

            }
            else{
                NavigationView{
                    ZStack{
                        
                        AngularGradient(gradient: Gradient(colors: [.red, .blue, .red, .white, .blue, .red, .white ]), center: .center)
                            .opacity(0.3)

                        VStack(spacing: 100){
                            LottieView(name: "welcome", loopMode: .loop)
                                .frame(width: UIScreen.main.bounds.width - 50, height: 250)
                                .opacity(0.7)
                                .clipShape(Capsule())
                                
                                NavigationLink(
                                    destination: Login(),
                                    label: {
                                        HStack{
                                            Text("Login")
                                                .fontWeight(.light)
                                                .padding(.trailing, 25)
                                                .font(.system(size: 22))
                                        }
                                        .foregroundColor(Color.red)
                                        .frame(width: 250, height: 50, alignment: .center)
                                        .background(.ultraThinMaterial)
                                        .background(Color.teal)
                                        .clipShape(Capsule())

                                        
                                        
                                    })
                                    .padding()
                                
                            
                            
                        }
                        .edgesIgnoringSafeArea(.all)
                        
                        NavigationLink(destination: About(), label: {
                            Image(systemName: "info.circle")
                                
                        })
                            .frame(width: UIScreen.main.bounds.width-20, height: UIScreen.main.bounds.height-30, alignment: .bottomLeading)
                        .foregroundColor(.blue)
                        .font(.system(size: 20))
                        .shadow(color: .gray, radius: 5.0, x: 1.0, y: 5)
                        .padding(.bottom,30)
                    }
                    .edgesIgnoringSafeArea(.all)
                    
                }
                .edgesIgnoringSafeArea(.all)
                .navigationViewStyle(StackNavigationViewStyle())
            }
        }
            
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Loading: View {
    @State var animate = false
    var body: some View {
            ZStack{
                
                
                    Circle()
                        .trim(from: 0, to: 0.8)
                        .stroke(AngularGradient(gradient: .init(colors: [.blue,.yellow]), center: .center), style: StrokeStyle(lineWidth: 8, lineCap: .round))
                        .frame(width: 35, height: 35)
                        .rotationEffect(.init(degrees: animate ? 360 : 0))
                        .animation(Animation.linear(duration: 0.7).repeatForever(autoreverses: false) , value: self.animate )
                        
                    
                }
                .padding()
                .onAppear(perform: {
                    withAnimation(Animation.linear.speed(0.7)){
                        self.animate.toggle()
                    }
                })
                
                    
            }
            
            
        
        }
