//
//  CircularTimerView.swift
//  Doodie
//
//  Created by 수진 on 10/12/25.
//

import SwiftUI

import SwiftUI

struct CircularTimerView: View {
    @Environment(TimerViewModel.self) var timerViewModel
    
    // 초단위
    var totalTime: Double
    @State var timeRemaining: Double

    
    var body: some View {
        ZStack {
            // 배경 원
            Circle()
                .stroke(Color.gray.opacity(0.2), lineWidth: 20)
            
            // 진행 원
            Circle()
                .trim(from: 0, to: CGFloat(timeRemaining / totalTime))
                .stroke(Color.yellow, style: StrokeStyle(lineWidth: 20, lineCap: .round))
                .rotationEffect(.degrees(90)) // 12시 방향 시작
                .scaleEffect(x: 1, y: -1, anchor: .center) // 반전해서 시계방향
                .animation(.linear(duration: 1), value: timeRemaining)
            
            VStack{
                // 남은 시간 표시
                HStack{
                    var hourString : String {
                        if(timeRemaining > 3600){
                            let hour = Int(timeRemaining)/3600
                            return String(format: "%02d", hour)+":"
                        }
                        return ""
                    }
                    let minute = makeMinute(timeRemaining: timeRemaining)
                    let second = Int(timeRemaining)%60
                    let timeString = String(format: "%02d:%02d", minute, second)
                    Text("\(hourString)\(timeString)")
                        .font(.system(size: 40, weight: .bold))
                }
                
                // 진행률 표시
                let completionRatio = Int((totalTime-timeRemaining)/totalTime*100)
                Text("\(completionRatio)% 완료")
                    .foregroundStyle(.gray)
            }
            
            
        }
        .frame(width: 200, height: 200)
        .padding(.horizontal, 80)
        .padding(.vertical, 42)
        .background(RoundRectangle_20_Shadow(width: .infinity, height: .infinity, color: Color.white))
        .onAppear {
            startTimer()
        }
    }
    
    // 타이머
    func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if timeRemaining > 0 {
                timeRemaining -= 1
                timerViewModel.remainingTime = timeRemaining
                // 구독 안하는 값인데 계속 업데이트
            } else {
                timer.invalidate()
                Task{
                    await timerViewModel.endActivity()
                }
                
            }
        }
    }
    
    func makeMinute(timeRemaining : Double) -> Int{
        var min = Int(timeRemaining)
        if(timeRemaining > 3600){
            min = min - Int(timeRemaining/3600)*3600
        }
        var minute = min/60
//        while(minute >= 60){
//            minute/=60
//        }
        return minute
    }
}


#Preview {
    CircularTimerView(totalTime: 20, timeRemaining: 10)
}
