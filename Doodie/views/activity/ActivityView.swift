//
//  ActivityView.swift
//  Doodie
//
//  Created by 수진 on 10/11/25.
//

import SwiftUI

struct ActivityView: View {
    
    @Binding var path: [ViewPath]
    @Bindable var activityViewModel = ActivityViewModel()
    
    var body: some View {
        VStack{
            // 툴바
            Toolbar(title: "어떤 활동을 할까요?", description: "오늘 할 활동을 골라주세요!", path: $path)
            
            Spacer()
            // 추천 메세지
            Text("💡 \(activityViewModel.recommendMsg)")
                .padding(20)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.white)
                        .shadow(radius: 10)
                )
            
            // 챗봇 이동
            Button{
                path.append(ViewPath(type: .chatBot))
            }label: {
                ZStack{
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.white)
                        .frame(width: .infinity, height: 100)
                        .shadow(radius: 10)
                    
                    WaveBackgroundView()
                        .frame(width: .infinity, height: 100)
                    
                    
                    HStack{
                        Text("🤖")
                            .font(.title)
                        Text("AI에게 물어보기")
                            .font(.title)
                            .foregroundStyle(.black)
                            .fontWeight(.bold)
                    }
                }.padding(.horizontal, 20)
                    .padding(.top, 30)
            }
            
            // 기본 활동
            Grid{
                // 첫번째 열
                GridRow{
                    Spacer()
                    Button{
                        path.append(ViewPath(type: .timerView(activityId: 1)))
                    }label: {
                        let activity = activityViewModel.activityList[0]
                        ActivityCardView(activityIcon: activity.activityIconUrl, activityName: activity.activityName, cardBackgroundColor: Color.lightPink)
                            .foregroundStyle(.black)
                            .frame(width: 150, height: 150)
                    }
                    
                    Spacer()
                    NavigationLink(destination: Text("임시")){
                        //                        NavigationLink(destination: TimerView(activityId: 2)){
                        
                        let activity = activityViewModel.activityList[1]
                        ActivityCardView(activityIcon: activity.activityIconUrl, activityName: activity.activityName, cardBackgroundColor: Color.lightPurple)
                            .foregroundStyle(.black)
                            .frame(width: 150, height: 150)
                    }
                    Spacer()
                }
                
                // 두번째 열
                GridRow{
                    Spacer()
                    NavigationLink(destination: Text("임시")){
                        //                        NavigationLink(destination: TimerView(activityId: 3)){
                        let activity = activityViewModel.activityList[2]
                        ActivityCardView(activityIcon: activity.activityIconUrl, activityName: activity.activityName, cardBackgroundColor: Color.lightYellow)
                            .foregroundStyle(.black)
                            .frame(width: 150, height: 150)
                    }
                    Spacer()
                    NavigationLink(destination: Text("임시")){
                        //                        NavigationLink(destination: TimerView(activityId: 4)){
                        let activity = activityViewModel.activityList[3]
                        
                        ActivityCardView(activityIcon: activity.activityIconUrl, activityName: activity.activityName, cardBackgroundColor: Color.skyBlue)
                            .foregroundStyle(.black)
                            .frame(width: 150, height: 150)
                    }
                    Spacer()
                }
            }.padding(.vertical, 20)
            
            // 앱 이용 팁
            Text("💡 활동을 선택하면 타이머를 설정할 수 있어요")
                .padding(20)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.white)
                        .shadow(radius: 10)
                )
            Spacer()
            
            
        }
        .navigationBarBackButtonHidden(true) // 기존 네비게이션 바 숨김
        .background(
            LinearGradient(colors: [.lightYellow, .lightPink, .lightPurple], startPoint: .topLeading, endPoint: .bottomTrailing)
        )
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    
    
}

#Preview {
    @Previewable @State var path : [ViewPath] = [ViewPath(type: .activity)]
    ActivityView(path: $path)
    
}

struct WaveShape: Shape {
    // 파동 이동 정도
    var phase: CGFloat
    var amplitude: CGFloat = 20
    var frequency: CGFloat = 1.5
    
    var animatableData: CGFloat {
        get { phase }
        set { phase = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: rect.midY))
        
        for x in stride(from: 0, through: rect.width, by: 1) {
            let relativeX = x / rect.width
            let y = rect.midY + sin(relativeX * frequency * 2 * .pi + phase) * amplitude
            path.addLine(to: CGPoint(x: x, y: y))
        }
        
        // 아래쪽 채우기
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        path.closeSubpath()
        
        return path
    }
}

struct WaveBackgroundView: View {
    @State private var phase: CGFloat = 0
    
    var body: some View {
        WaveShape(phase: phase)
            .fill(
                LinearGradient(
                    gradient: Gradient(colors: [.skyBlue, .cyan]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .ignoresSafeArea()
            .onAppear {
                withAnimation(.linear(duration: 2).repeatForever(autoreverses: false)) {
                    phase = 2 * .pi
                }
            }
    }
}
