//
//  ChatBotView.swift
//  Doodie
//
//  Created by 수진 on 10/11/25.
//

import SwiftUI

struct ChatBotView: View {
    @State var question: String = ""
    @State var isInit: Bool = true
    @Environment(\.dismiss) var dismiss
    
    @State private var messages: [ChatMessage] = [
        ChatMessage(text: "안녕하세요! 저는 여러분의 활동 도우미 두디 봇이에요 🤖 \n오늘 어떤 활동을 하고 싶으신지 말씀해주세요!", isMine: false, isActivity: false),
        ChatMessage(text: "안녕하세요! 반갑습니다.", isMine: true, isActivity: false),
        ChatMessage(text: "다음의 활동은 어떠세요?", isMine: false, isActivity: false),
        ChatMessage(text: "홈 트레이닝,집에서 가볍게 운동하기", isMine: false, isActivity: true),
        ChatMessage(text: "산책하기,콧구멍 바람쐬기", isMine: false, isActivity: true)
        ]
        
        @State private var inputText: String = ""
        @FocusState private var isFocused: Bool
    
    var body: some View {
        NavigationStack{
            VStack{
                // 툴바
                Toolbar(title: "AI 활동 도우미", description: "맞춤 활동을 찾아드려요", onBack:{dismiss()})
           
                // 채팅창
                ScrollViewReader { scrollProxy in
                    ScrollView {
                        VStack(spacing: 8) {
                            ForEach(messages) { msg in
                                // msg의 isActivity가 false면 일반 말풍선
                                // true면 활동 말풍선
                                if(msg.isActivity){
                                    var tmp : [String]{
                                        msg.text.split(separator: ",").map{String($0)}
                                    }
                                    var title : String {
                                        tmp[0]
                                    }
                                    var des : String {
                                        tmp[1]
                                    }
                                    
                                    NavigationLink(destination: TimerView(isProgress: false, activityIconUrl: "🎀", activityName: title, activityDescription: des)){
                                        ActivityBurbble(message: msg)
                                            .transition(.move(edge: msg.isMine ? .trailing : .leading).combined(with: .opacity))
                                            .id(msg.id)
                                    }
                                    
                                }else{
                                    ChatBubble(message: msg)
                                        .transition(.move(edge: msg.isMine ? .trailing : .leading).combined(with: .opacity))
                                        .id(msg.id)
                                    
                                }
                                
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 20)
                    }
                    .background(RoundedRectangle(cornerRadius: 20).fill(.white).shadow(radius: 10))
                    .onChange(of: messages.count) { _ in
                        withAnimation(.easeOut) {
                            scrollProxy.scrollTo(messages.last?.id, anchor: .bottom)
                        }
                    }.padding(.horizontal, 20)
                }
                
                
                // 추천 질문 리스트
                // 대화가 없을때만 보임.(초기상태)
                if(isInit){
                    Text("💡 이런 질문은 어떠세요?")
                        .foregroundStyle(.gray)
                        .padding(.vertical, 10)
                    List{
                        Text("오늘 날씨에 맞는 30분정도 할만한 활동을 추천해줘")
                        Text("집에서 할 수 있는 운동 추천해줘")
                        Text("창의적인 활동을 하고 싶어.")
                    }.frame(height: 200)
                }
                
                // 질문 입력 창
                // 여기서 쓸건아닌데 일단 메모. viewmodel에서 호출해서
                // 모델의 데이터를 바꾸는데 --> 모델이 화면임. (상태마다 데이터 가지고있는..)
                // 모델이 바뀌면 뷰가 업데이트되도록.
                
                // 근데 챗 내용 기록하게 둘까??
                // 내부 db에 저장해두면될듯..
                // 그럼 날짜 선도 필요한데...
                // 번거로우니까 매번 초기화하자 ㅎ
                HStack{
                    TextField("활동에 대해 물어보세요...", text: $question)
                        .padding(.horizontal, 20)
                        .frame(width: .infinity, height: 50)
                        .background(RoundedRectangle(cornerRadius: 20)
                            .fill(.white))
                    
                    Button{
                        // 서버로 보내기
                        // viewModel.sendMessage(question)
                        isInit = false
                    }label: {
                        Image(systemName: "paperplane")
                            .foregroundStyle(.gray)
                            .padding(20)
                            .frame(height: 50)
                            .aspectRatio(contentMode: .fit)
                            .background(RoundedRectangle(cornerRadius: 20).fill(.yellow))
                    }
                }.frame(width: .infinity, height: 50)
                    .padding(20)
            }.background(
                LinearGradient(colors: [.lightYellow, .lightPink, .lightPurple], startPoint: .topLeading, endPoint: .bottomTrailing)
            )
        }
        .navigationBarBackButtonHidden(true) // 기존 네비게이션 바 숨김
        .ignoresSafeArea(.keyboard)
        
    }
}

#Preview {
    ChatBotView()
}

struct ChatMessage: Identifiable {
    let id = UUID()
    let text: String
    let time: Date = Date()
    let isMine: Bool
    let isActivity :Bool // --> Activity면 말풍선 모양 달리하기... Navigation Link로 감싼 형태 나오기...
    //이미지..? ㅠ
}
// MARK: - 채팅 말풍선
struct ChatBubble: View {
    let message: ChatMessage
    
    var body: some View {
        VStack(alignment: message.isMine ? .trailing : .leading, spacing: 2) {
            HStack {
                if message.isMine { Spacer() }
                
                Text(message.text)
                    .padding(12)
                    .background(message.isMine ? Color.yellow : Color.lightPurple)
                    .foregroundColor(message.isMine ? .black : .black)
                    .cornerRadius(16, corners: message.isMine ? [.topLeft, .topRight, .bottomLeft] : [.topLeft, .topRight, .bottomRight])
                    .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 2)
                
                if !message.isMine { Spacer() }
            }
            
            // 시간 표시
            Text(message.time, style: .time)
                .font(.caption2)
                .foregroundColor(.gray)
                .padding(message.isMine ? .trailing : .leading, 8)
                .padding(.top, 8)
        }
        .padding(message.isMine ? .leading : .trailing, 50)
    }
}

// MARK: - Corner Radius Extension
struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct ActivityBurbble : View {
    let message: ChatMessage
    var tmp : [String]{
        message.text.split(separator: ",").map{String($0)}
    }
    var title : String {
        tmp[0]
    }
    var des : String {
        tmp[1]
    }
    var body: some View{
//        VStack(alignment: message.isMine ? .trailing : .leading, spacing: 2){
//            HStack{
//                Text("💗")
//                VStack(alignment: .leading){
//                    Text(title)
//                        .fontWeight(.bold)
//                        .foregroundStyle(.black)
//                    Text(des)
//                        .foregroundStyle(.gray)
//                }.padding(.vertical, 10)
//                Spacer()
//                Image(systemName: "chevron.right")
//                    .tint(.yellow)
//            }
//            .padding(.trailing, 30)
//        }
//        .padding(.leading, 10)
//        .frame(width: 200)
//        .background(RoundedRectangle(cornerRadius: 20).fill(.lightYellow))
        
        VStack(alignment: message.isMine ? .trailing : .leading, spacing: 2) {
            HStack {
                if message.isMine { Spacer() }
                
                HStack {
                    Text("💗")
                    VStack(alignment: .leading){
                        Text(title)
                            .fontWeight(.bold)
                            .foregroundStyle(.black)
                        Text(des)
                            .foregroundStyle(.gray)
                    }.padding(.vertical, 10)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .tint(.yellow)

                }.padding(12)
                    .background(RoundedRectangle(cornerRadius: 20).fill(.lightYellow))
                    .foregroundColor(message.isMine ? .black : .black)
                    .cornerRadius(16, corners: message.isMine ? [.topLeft, .topRight, .bottomLeft] : [.topLeft, .topRight, .bottomRight])
                    .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 2)
                
                if !message.isMine { Spacer() }
            }
            
        }
        .padding(message.isMine ? .leading : .trailing, 50)
    }
    
}
