//
//  Verification.swift
//  Verification
//
//  Created by Mister Okine on 25/07/2021.
//

import Firebase
import SwiftUI

struct Verification: View {
    
    @State var loading = false
    
    @ObservedObject var loginData : LoginViewModel
    @Environment(\.presentationMode) var present

    var body: some View {
        
        ZStack{
            AngularGradient(gradient: Gradient(colors: [.red, .blue, .red, .white, .blue, .red, .white ]), center: .center)
                .opacity(0.3)
            VStack{
                
                VStack{
                    
                    HStack{
                        
//                        Button(action: {present.wrappedValue.dismiss()}) {
//                            
//                            Image(systemName: "arrow.left")
//                                .font(.title2)
//                                .foregroundColor(.black)
//                        }
                        
                        Spacer()
                        
                        Text("Verify Phone Number")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                        
                        Spacer()
                        
                        if loginData.loading{ProgressView()}
                    }
                    .padding()
                    
                    Text("Code sent to +\(loginData.getCountryCode())\(loginData.phoneNumber)")
                        .foregroundColor(.gray)
                        .padding(.bottom)
                    
                    Spacer(minLength: 0)
                    
                    LottieView(name: "verification", loopMode: .loop)
                        .frame(width: UIScreen.main.bounds.width-100 , height: 170, alignment: .center)
                    
                    HStack(spacing: 15){
                        
                        ForEach(0..<6,id: \.self){index in
                            
                            // displaying code....
                            
                            CodeView(code: getCodeAtIndex(index: index))
                        }
                    }
                    .padding()
                    .padding(.horizontal,20)
                    
                    Spacer(minLength: 0)
                    
                    HStack(spacing: 6){
                        
                        Text("Didn't receive code?")
                            .foregroundColor(.teal)
                            
                        
                        Button(action: loginData.requestCode) {
                            
                            Text("Request Again")
                                .fontWeight(.regular)
                                .foregroundColor(.red)
                                .italic()
                        }
                    }
                    if self.loading{
                        Spacer()
                        LottieView(name: "loading-spinner", loopMode: .loop)
                            .frame(width: 50, height: 50)
                        Spacer()
                        
                    }
                    else {
                        Button(action: {
                            self.loading.toggle()
                            loginData.verifyCode()
                        })
                        {
                            Text("Verify and Continue")
                                .foregroundColor(.white)
                                .padding(.vertical)
                                .frame(width: UIScreen.main.bounds.width - 30)
                                .background(Color.blue)
                                .cornerRadius(15)
                        }
                        .padding()
                    }
                }
                .frame(height: UIScreen.main.bounds.height / 1.8)

                CustomNumberPad(value: $loginData.code, isVerify: true)
            }
            .background(.thinMaterial)
            .ignoresSafeArea(.all, edges: .bottom)
            
            if loginData.error{
                
                AlertView(msg: loginData.errorMsg, show: $loginData.error)
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
    
    // getting Code At Each Index....
    
    func getCodeAtIndex(index: Int)->String{
        
        if loginData.code.count > index{
            
            let start = loginData.code.startIndex
            
            let current = loginData.code.index(start, offsetBy: index)
            
            return String(loginData.code[current])
        }
        
        return ""
    }
    
    

}



struct CodeView: View {
    
    var code: String
    
    var body: some View{
        
        VStack(spacing: 10){
            
            Text(code)
                .foregroundColor(.black)
                .fontWeight(.light)
                .font(.title2)
            // default frame...
                .frame(height: 45)
            
            Capsule()
                .fill(Color.gray.opacity(0.4))
                .frame(height: 4)
        }
    }
}
