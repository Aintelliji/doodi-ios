//
//  TimerView.swift
//  Doodie
//
//  Created by 수진 on 10/12/25.
//

import SwiftUI

struct TimerView: View {
    
    @Binding var path: [ViewPath]
//    var activityId : String
    @Bindable var timerViewModel : TimerViewModel

    init(path: Binding<[ViewPath]>, activity: ActivityDto) {
        self._path = path
        // TimerViewModel 초기화
        self._timerViewModel = Bindable(TimerViewModel(activity: activity))
    }

    
    var body: some View {
            
            VStack{
                // 툴바
                Toolbar(title: "타이머 ⏰", description: "집중해서 활동해보세요", path: $path)
                
                // 선택한 활동 설명
                VStack{
                    // Image("") 아이콘...
                    Text(timerViewModel.activityDto.activityIconUrl)
                        .font(.title)
                    Text(timerViewModel.activityDto.activityName)
                        .font(.title2)
                        .fontWeight(.bold)
                    Text(timerViewModel.activityDto.activityDescription)
                        .foregroundStyle(.gray)
                }
                .padding(.horizontal, 100)// geometry같은걸로 전체 너비 구해서 빼기?;;
                .padding(.vertical, 32)
                .background(RoundRectangle_20_Shadow(width: .infinity, height: 150, color: Color.lightYellow))
                
                // RoundRectangle_20_Shadow(width: .infinity, height: 150, color: Color.cyan)
                
                // 타이머부분
                // 진행중이면 진행 창 및 활동 중지 버튼
//                // 진행중이 아니면 타이머 설정 버튼
                switch timerViewModel.timerViewStatus{
                case .TimerSetting:
                    TimerSettingView().padding(20)
                        .environment(timerViewModel)
                case .TimerProgress:
                    TimerProgressView().padding(20)
                        .environment(timerViewModel)
                        .onAppear{
                            // 이렇게 하니까 TimerView가 새로그려지나봐... ViewModel도 다시 불러와짐...
//                            if let last = path.last {
//                                path = [last]
//                            }
                        }
                }
                
                Spacer()
                
                
   
            }
            .navigationBarBackButtonHidden(true) // 기존 네비게이션 바 숨김
            .background(
                LinearGradient(colors: [.lightYellow, .lightPink, .lightPurple], startPoint: .topLeading, endPoint: .bottomTrailing)
            )
        .onChange(of: timerViewModel.endActivityEventStatus) { newStatus in
            switch newStatus {
            case .Finished, .EarlyFinished:
                path.append(ViewPath(type: .resultView))
            print("End")
            case .NotEnded:
                path.append(ViewPath(type: .resultView))
                print("Not Ended")
            }
        }
    }
}

