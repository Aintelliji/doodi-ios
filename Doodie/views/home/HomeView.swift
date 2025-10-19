//
//  HomeView.swift
//  Doodie
//
//  Created by 수진 on 10/11/25.
//

import SwiftUI

struct HomeView: View {
    @State var path : [ViewPath] = []
    @StateObject var homeViewModel = HomeViewModel()
    
    @State private var selectedTab = 0
    
    let tabTitles = ["기록", "업적", "달력"]
    
    var body: some View {
        // 전체를 Navigation Stack으로 감싼다.
        NavigationStack(path: $path){
            
            ScrollView{
                
                VStack{
                    // 성장하는 캐릭터
                    Image("character-sample")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 350, height: 350)
                        .padding(.bottom, 20)
                    // 레벨 영역
                    ZStack{
                        RoundedRectangle(cornerRadius: 24)
                            .fill(.white)
                            .frame(height: 160)
                            .shadow(radius: 10)
                        VStack{
                            Spacer()
                            // 레벨
                            Text("레벨 \(homeViewModel.characterInfo!.level)")
                                .font(.title)
                                .fontWeight(.bold)
                            
                            // 남은 경험치
                            Text("다음 레벨까지 \((homeViewModel.characterInfo!.maxExpOfCurrentLevel) - homeViewModel.characterInfo!.currentExp) exp")
                                .foregroundStyle(.gray)
                                .padding(.bottom, 12)
                            
                            
                            // 경험치 바
                            VStack{
                                ProgressView(value: Float(homeViewModel.characterInfo!.currentExp), total: Float(homeViewModel.characterInfo!.maxExpOfCurrentLevel))
                                    .progressViewStyle(ExpProgressStyle())
                                    .frame(height: 12)
                                HStack{
                                    Text("\(homeViewModel.characterInfo!.minExpOfCurrentLevel) EXP")
                                    Spacer()
                                    Text("\(homeViewModel.characterInfo!.maxExpOfCurrentLevel) EXP")
                                }
                            }
                            .padding(.horizontal, 40)
                            
                            Spacer()
                        }
                    } // zstack
                    .padding(.bottom, 20)
                    
                    
                    
                    
                    // 활동 상태창
                    switch homeViewModel.activityStatusViewState{
                    case .NewActivity:
                        Button{
                            path.append(ViewPath(type: .activity, timerValue: nil))
                        }label: {
                            ZStack{
                                // 베경
                                RoundedRectangle(cornerRadius: 24)
                                    .fill(.white)
                                    .shadow(radius: 10)
                                HStack{
                                    Spacer()
                                    Image("Logo-ani")
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                    VStack(alignment: .leading){
                                        Text("새로운 활동 시작")
                                            .font(.title3)
                                            .fontWeight(.bold)
                                            .foregroundStyle(.black)
                                        Text("휴대폰을 잠시 내려두고 성장해보세요")
                                            .foregroundStyle(.gray)
                                    }
                                    Spacer()
                                }.frame(height: 100)
                        }
                        
                        
//                        NavigationLink(destination: ActivityView()){
//                            ZStack{
//                                // 베경
//                                RoundedRectangle(cornerRadius: 24)
//                                    .fill(.white)
//                                    .shadow(radius: 10)
//                                HStack{
//                                    Spacer()
//                                    Image("Logo-ani")
//                                        .resizable()
//                                        .frame(width: 50, height: 50)
//                                    VStack(alignment: .leading){
//                                        Text("새로운 활동 시작")
//                                            .font(.title3)
//                                            .fontWeight(.bold)
//                                            .foregroundStyle(.black)
//                                        Text("휴대폰을 잠시 내려두고 성장해보세요")
//                                            .foregroundStyle(.gray)
//                                    }
//                                    Spacer()
//                                }
//                            }
//                            .frame(height: 100)
                            
                        }
                        .padding(.bottom, 20)
                        
                        
                    case.ProgressingActivity:
                        VStack{}
                    }
                    
                    
                    
                    // 기록-업적-달력 창
                    VStack(spacing: 16) {
                        // 상단 탭 버튼
                        HStack(spacing: 8) {
                            ForEach(0..<tabTitles.count, id: \.self) { index in
                                Button(action: {
                                    withAnimation(.spring()) {
                                        selectedTab = index
                                    }
                                }) {
                                    Text(tabTitles[index])
                                        .font(.system(size: 16, weight: selectedTab == index ? .bold : .medium))
                                        .foregroundColor(selectedTab == index ? .black : .gray)
                                        .padding(.vertical, 8)
                                        .frame(maxWidth: .infinity)
                                        .background(
                                            RoundedRectangle(cornerRadius: 20)
                                                .fill(selectedTab == index ? Color.white : Color(.systemGray6))
                                                .shadow(color: selectedTab == index ? Color.black.opacity(0.1) : .clear,
                                                        radius: 3, x: 0, y: 2)
                                        )
                                }
                            }
                        }
                        .padding(.horizontal)
                        
                        // 하위 콘텐츠
                        TabView(selection: $selectedTab) {
                            RecordView()
                                .tag(0)
                            AchievementView()
                                .tag(1)
                            CalendarView()
                                .tag(2)
                        }.frame(height: 300)
                    }
                } // vstack
                .padding(20)
                
            } // scroll view
            .background(
                LinearGradient(colors: [.lightYellow, .lightPink, .lightPurple], startPoint: .topLeading, endPoint: .bottomTrailing)
            ).navigationDestination(for: ViewPath.self){ route in
                
                switch route.type {
                   
                case .login:
                    LoginView()
                case .homeView:
                    HomeView()
                case .activity:
//                    Text("임시")
                    ActivityView(path: $path)
                case .chatBot:
                    //ChatBotView(path: $path)
                    Text("임시")
                case .timerView(let activityId):
                    Text("임시")
//                    TimerView(path: $path, activityId: route.timerValue)
                case .resultView:
                    ResultView(activityDto: ActivityDto(activityId: 1, activityIconUrl: "💪", activityName: "운동하기", activityDescription: "몸을 움직여 건강해져요"), activityTime: 1, exp: 1, maxExp: 1, remainingExp: 1, recordText: "")
                    
                }
            }
        } // navigation stack
        .navigationBarBackButtonHidden(true) // 기존 네비게이션 바 숨김
        
        
    }
}


#Preview {
    NavigationStack{
        HomeView()
    }

}


struct ExpProgressStyle: ProgressViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                // 배경
                Capsule()
                    .fill(.lightGray)
                    .frame(height: geometry.size.height)
                
                // 진행 부분
                Capsule()
                    .fill(.black)
                    .frame(width: geometry.size.width * CGFloat(configuration.fractionCompleted ?? 0.0),
                           height: geometry.size.height)
            }
        }
    }
}

struct TabButton: View {
    let title: String
    let index: Int
    @Binding var selectedTab: Int
    
    var body: some View {
        Button {
            withAnimation {
                selectedTab = index
            }
        } label: {
            VStack(spacing: 4) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(selectedTab == index ? .black : .gray)
                if selectedTab == index {
                    Capsule()
                        .fill(Color.blue)
                        .frame(height: 3)
                        .matchedGeometryEffect(id: "underline", in: Namespace().wrappedValue)
                } else {
                    Capsule()
                        .fill(Color.clear)
                        .frame(height: 3)
                }
            }
            .frame(maxWidth: .infinity)
        }
    }
}






