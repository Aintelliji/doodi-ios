//
//  TimerSettingView.swift
//  Doodie
//
//  Created by 수진 on 10/12/25.
//

import SwiftUI

struct TimerProgressView: View {
    @Environment(TimerViewModel.self) var timerViewModel
    
    var body: some View {

            VStack{
               
                CircularTimerView(totalTime: timerViewModel.activityDto.totalTime ?? 60, timeRemaining: timerViewModel.activityDto.remainingTime ?? 60)
                    .environment(timerViewModel)
                
                // 버튼
//                NavigationLink(destination: ResultView(exp: 100, maxExp: 200, remainingExp: 50)){
//                    HStack {
//                        Text("활동 종료")
//                            .fontWeight(.semibold)
//                            .foregroundColor(.black)
//                    }
//                    .frame(maxWidth: .infinity)
//                    .padding()
//                    .background(Color.white)
//                    .cornerRadius(20)
//                    .shadow(color: .gray, radius: 4, x: 0, y: 4)
//                }.padding(.top, 24)
                
                Button(action: {
                    // 활동 종료 후
                    timerViewModel.endActivity( )
                    // 경험치 받아서..?
                    // 결과화면에 주입 혹은 결과화면으로 이동, 활동 id 주입
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
                    
                 
            }.navigationBarBackButtonHidden(true) // 기존 네비게이션 바 숨김
        }

    
}


