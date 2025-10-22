//
//  ContentView.swift
//  Doodie
//
//  Created by 수진 on 10/11/25.
//

import SwiftUI

struct ContentView: View {
    
    // 회원 관련 뷰모델
    // 임시
    @State var isLogin = false
    
    
    var body: some View {
        if(!isLogin){
            Button{
                isLogin.toggle()
            } label: {
                Text("로그인여부: \(isLogin)")
            }
        }
        
            if (isLogin) {
                HomeView().tint(.black)
            }else{
                LoginView()
            }
        }

}


#Preview {
    ContentView()
}


