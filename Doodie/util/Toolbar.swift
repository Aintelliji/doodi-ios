//
//  Toolbar.swift
//  Doodie
//
//  Created by 수진 on 10/12/25.
//

import SwiftUI

struct Toolbar: View {
    
    var title: String
    var description: String
    var onBack: () -> Void //뒤로가기 액션 전달
    
    var body: some View {
        // 커스텀 툴바
        HStack {
            Button(action: onBack) {
                    Image(systemName: "arrow.backward")
                    .tint(.black)
            }.padding(.trailing, 20)
            
            VStack(alignment: .leading){
                Text(title)
                    .font(.title2)
                    .fontWeight(.bold)
                Text(description)
                    .foregroundStyle(.gray)
            }.padding(.vertical, 20)
            
            Spacer()
            
        }.padding(.horizontal, 20)
    }
}

#Preview {
    Toolbar(title: "어떤 활동을 할까요?", description: "오늘의 활동을 골라주세요!", onBack: {})
}

