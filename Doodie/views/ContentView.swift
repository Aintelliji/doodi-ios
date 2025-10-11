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
    var isLogin = true
    
    
    var body: some View {
        if (isLogin) {
            HomeView()
        }else{
            LoginView()
        }
    }
}

#Preview {
    ContentView()
}
