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

    
    let userRepository = UserRepository()
    @State var isLogin: Bool
    
    var body: some View {
        VStack{
            
                if (isLogin) {
                    HomeView().tint(.black)
                }else{
                    LoginView()
                }
        }.onAppear{
            Task{
                isLogin = await userRepository.getProgressState() ?? false
            }
           
        }
        
    }

}


#Preview {
    ContentView(isLogin: false)
}


