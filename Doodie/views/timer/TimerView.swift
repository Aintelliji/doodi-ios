//
//  TimerView.swift
//  Doodie
//
//  Created by 수진 on 10/12/25.
//

import SwiftUI

struct TimerView: View {
    @Environment(\.dismiss) var dismiss
    
    @StateObject var timerViewModel = TimerViewModel()
    var activityDto: ActivityDto
    
    
    var body: some View {
        VStack{
            // 툴바
            Toolbar(title: "타이머 ⏰", description: "집중해서 활동해보세요", onBack:{dismiss()})
            
            // 선택한 활동 설명
            VStack{
                // Image("") 아이콘...
                Text(activityDto.activityIconUrl)
                    .font(.title)
                Text(activityDto.activityName)
                    .font(.title2)
                    .fontWeight(.bold)
                Text(activityDto.activityDescription)
                    .foregroundStyle(.gray)
            }
            .padding(.horizontal, 100)// geometry같은걸로 전체 너비 구해서 빼기?;;
            .padding(.vertical, 32)
            .background(RoundRectangle_20_Shadow(width: .infinity, height: 150, color: Color.lightYellow))
            
            // RoundRectangle_20_Shadow(width: .infinity, height: 150, color: Color.cyan)
            
            // 타이머부분
            // 진행중이면 진행 창 및 활동 중지 버튼
            // 진행중이 아니면 타이머 설정 버튼
            switch timerViewModel.timerViewStatus{
            case .TimerSetting:
                TimerSettingView().padding(20)
                    .environmentObject(timerViewModel)
            case .TimerProgress:
                TimerProgressView(totalTime: 100).padding(20)
            }
            
            Spacer()
        }
        .navigationBarBackButtonHidden(true) // 기존 네비게이션 바 숨김
        .background(
            LinearGradient(colors: [.lightYellow, .lightPink, .lightPurple], startPoint: .topLeading, endPoint: .bottomTrailing)
        )
    }
}

#Preview {
    TimerView(activityDto: ActivityDto(activityIconUrl: "💪", activityName: "운동하기", activityDescription: "몸을 움직여 건강해져요"))
}
