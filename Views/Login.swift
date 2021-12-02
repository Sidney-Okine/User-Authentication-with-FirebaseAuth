//
//  Login.swift
//  Login
//
//  Created by Mister Okine on 25/07/2021.
//

import SwiftUI
import Firebase
import Lottie

struct Login: View {

    @State var loading = false
    @State var show = false
    @AppStorage("log_Status") var status = false
    @StateObject var loginData = LoginViewModel()
    @State var isSmall = UIScreen.main.bounds.height < 750
    
        var body: some View {
            
            ZStack{
                AngularGradient(gradient: Gradient(colors: [.red, .blue, .red, .white, .blue, .red, .white ]), center: .center)
                    .opacity(0.3)
                

                VStack{
                    
                    VStack{
                        
                        Text("Continue With Phone")
                            .font(.title2)
                            .fontWeight(.ultraLight)
                            .foregroundColor(.black)
                            .padding(.top,70)
                        
                        
                        LottieView(name: "otp", loopMode: .loop)
                            .frame(width: UIScreen.main.bounds.width-100, height: 200, alignment: .center)
                            .padding(.top,50)
                            
                    
                            
                        
                        // Mobile Number Field....
                        
                        HStack{
                            
                            VStack(alignment: .leading, spacing: 6) {
                                
                                Text("Enter Your Number")
                                    .font(.caption)
                                    .foregroundColor(.black)
                                    .fontWeight(.light)
                                
                                
                                Text("+ \(loginData.getCountryCode()) \(loginData.phoneNumber)")
                                    .font(.title2)
                                    .fontWeight(.light)
                                    .foregroundColor(.black)
                                
                            }
                            
                            Spacer(minLength: 0)
                            
                            NavigationLink(destination: Verification(loginData: loginData),isActive: $loginData.gotoVerify) {
                                
                                Text("")
                                    .hidden()
                            }
                            if self.loading{
                                
                                HStack{
                                    
                                    Spacer()
                                    Loading()
                                    Spacer()
                                }
                            }
                            else{

                                Button( action: {
                                    self.loading.toggle()
                                    loginData.sendCode()
                                })
                                {
                                    Text("Continue")
                                        .foregroundColor(.white)
                                        .padding(.vertical,18)
                                        .padding(.horizontal,38)
                                        .background(Color.blue).opacity(0.9)
                                        .cornerRadius(15)
                                }
                                .disabled(loginData.phoneNumber == "" ? true: false)
                            }

                        }
                        .padding()
                        .cornerRadius(20)
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: -5)
                    }
                    .background(.thinMaterial)
                    .frame(height: UIScreen.main.bounds.height / 1.8)
                    .cornerRadius(20)

                    // Custom Number Pad....
                    
                    CustomNumberPad(value: $loginData.phoneNumber, isVerify: false)

                }
                
                if loginData.error{
                    
                    AlertView(msg: loginData.errorMsg, show: $loginData.error)

                }
            }
            .edgesIgnoringSafeArea(.all)
        }
        
    }

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
