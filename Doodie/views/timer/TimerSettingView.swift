//
//  TimerSettingView.swift
//  Doodie
//
//  Created by 수진 on 10/12/25.
//

import SwiftUI

struct TimerSettingView: View {
    
    @State private var selectedTime: Double = 30
    @Environment(TimerViewModel.self) var timerViewModel
    
    var body: some View {
        VStack{
            VStack{
                // 타이틀
                Text("목표 시간 설정")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                
                // 선택된 시간 표시
                Text("\(Int(selectedTime))분")
                    .font(.system(size: 40, weight: .bold))
                    .foregroundColor(.black)
                
                // 기본 슬라이더
                //            Slider(
                //                value: $selectedTime,
                //                in: 5...120,
                //                step: 5
                //            )
                //            .accentColor(.black) // 슬라이더 색상
                //            .padding(.horizontal, 30)
                CustomSliderView(value: $selectedTime, range: 5...120)
                    .padding(.horizontal, 30)
                
                // 최소, 최대값 라벨
                HStack {
                    Text("5분")
                        .foregroundColor(.gray)
                        .font(.subheadline)
                    Spacer()
                    Text("120분")
                        .foregroundColor(.gray)
                        .font(.subheadline)
                }
                .padding(.horizontal, 30)
            }
            .padding(.vertical, 50)
            .background(RoundRectangle_20_Shadow(width: .infinity, height: .infinity, color: Color.white))
            
            
            // 버튼
//            NavigationLink(destination: TimerProgressView(totalTime: selectedTime)){
//                HStack {
//                    Text("🚀 시작하기")
//                        .fontWeight(.semibold)
//                        .foregroundColor(.black)
//                }
//                .frame(maxWidth: .infinity)
//                .padding()
//                .background(Color.yellow)
//                .cornerRadius(20)
//                .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 4)
//                .padding(.top, 24)
//            }
            Button(action: {
                // 타이머 시작
                timerViewModel.startActivity(selectedTime: selectedTime)
            }) {
                HStack {
                    Text("🚀 시작하기")
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.yellow)
                .cornerRadius(20)
                .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 4)
            }.padding(.top, 24)
            
        }
        
    }
}


#Preview {
    TimerSettingView()
}
