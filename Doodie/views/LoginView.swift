//
//  LoginView.swift
//  Doodie
//
//  Created by 수진 on 10/11/25.
//

import SwiftUI

struct LoginView: View {
    @State private var bounce = false
    
    var body: some View {
        VStack{
            Spacer()
            
            ZStack{
                
                // 배경 사각형
                RoundedRectangle(cornerRadius: 40)
                    .fill(.white)
                    .frame(height: 360)
                    .shadow(radius: 10)
                    .padding(16)
                // 로고, 제목, 로그인 버튼
                VStack{
                    Spacer()
                    // 로고이미지
                    ZStack {
                        Image("Logo-Img")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 150, height: 150)
                            .overlay(
                                Image("Logo-ani")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .offset(y: bounce ? 30 : 10)
                                .animation(
                                    .easeInOut(duration: 0.6)
                                    .repeatForever(autoreverses: true),
                                    value: bounce
                                ))
                        
                    }.onAppear{
                        bounce = true
                    }
                    
                    // 제목
                    Text("두디(Doodi)")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.bottom, 2)
                    Text("휴대폰 없이 즐겁게 활동 기록하기")
                    
                    Button{
                        // Login Action
                    } label: {
                        Label{
                            Text("구글 로그인")
                        } icon: {
                            Image("google")
                            
                        }.foregroundStyle(.black)
                            .font(.title3)
                            .frame(width: 300)
                            .padding(.horizontal)
                            .padding(.vertical)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                .fill(.yellow)
                            )
                            
                    }.padding(.top, 24)
                    Spacer()
                }
                .padding(32)
                
            }
            
            
            Spacer()
            
        }
        .background(LinearGradient(gradient: Gradient(colors: [Color("Light-Yellow"), Color("Light-Pink"), Color("Light-Purple")]), startPoint: .topLeading, endPoint: .bottomTrailing))
    }
}

#Preview {
    LoginView()
}

// 나중에 커스텀 스타일로 분리?;;
//struct RoundButton: ButtonStyle{
//    var labelColor : Color
//    var backgroundColor: Color
//    
//    init(labelColor: Color, backgroundColor: Color) {
//        self.labelColor = labelColor
//        self.backgroundColor = backgroundColor
//    }
//  func makeBody(configuration: Configuration) -> some View {
//    configuration.label
//      .foregroundColor(labelColor)
//      .padding(.init(horizontal: 20, vertical: 13))
//      .background(Capsule().fill(backgroundColor))
//      .scaleEffect(configuration.isPressed ? 0.88 : 1.0) // <-
//  }
//}
