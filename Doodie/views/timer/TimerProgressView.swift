//
//  TimerSettingView.swift
//  Doodie
//
//  Created by 수진 on 10/12/25.
//

import SwiftUI

struct TimerProgressView: View {
    @State private var selectedTime: Double = 30
    var totalTime : Double = 100
    var timeRemaining : Double = 100
    
    var body: some View {
        VStack{
           
            CircularTimerView(totalTime: totalTime, timeRemaining: timeRemaining)
            
            // 버튼
            Button(action: {
                
            }) {
                HStack {
                    Text("활동 종료")
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.white)
                .cornerRadius(20)
                .shadow(color: .gray, radius: 4, x: 0, y: 4)
            }.padding(.top, 24)
            
            Text("📱 휴대폰을 멀리 두고 집중하세요!")
                .foregroundStyle(.blue)
                .padding(.vertical, 32)
                .frame(maxWidth: .infinity)
                .background(RoundRectangle_20_Shadow(width: .infinity, height: 50, color: .skyBlue))
    
                
             
        }
        
    }
}


#Preview {
    TimerProgressView()
}
