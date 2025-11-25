//
//  ResultView.swift
//  Doodie
//
//  Created by 수진 on 10/12/25.
//

import SwiftUI

struct ResultView: View {
    
    @Binding var path: [ViewPath]
    @Bindable var resultViewModel : ResultViewModel
//    var activityDto = ActivityDto(activityId: "1", activityIconUrl: "💪", activityName: "운동", activityDescription: "건강해져봅시다. 다이어트 좀 합시다.", typeId: 1)
    var result : ResultDto
    var completeMin: Int
    
    init(path: Binding<[ViewPath]>, result: ResultDto) {
        self._path = path
        self.result = result
        self._resultViewModel = Bindable(ResultViewModel())
        completeMin = (Int(result.activity.totalTime ?? 0) - Int(result.activity.remainingTime ?? 0))/60
    }
    

//    var activityTime: Int = 30
//    // 획득한 경험치 - 서버에서 받아옴..!
//    var exp: Int
//    var maxExp: Int // 현재 레벨 최대 경험치
//    var remainingExp: Int // 레벨업까지 남은 경험치
    
    @State var recordText : String = ""
    
    var body: some View {
        
        ScrollView{
            VStack{
                // 선택한 활동
                VStack{
                    // Image("") 아이콘...
                    Text(result.activity.activityIconUrl)
                        .font(.title)
                    Text(result.activity.activityName)
                        .font(.title2)
                        .fontWeight(.bold)
                    Text(result.activity.activityDescription)
                        .frame(alignment: .center)
                        .foregroundStyle(.white)
                }
                .padding(.horizontal, 100)// geometry같은걸로 전체 너비 구해서 빼기?;;
            
                VStack{
                    // 아 변환 작업 또 해야겠네..;;
                    Text("\(completeMin)분")
                        .font(.title)
                        .fontWeight(.bold)
                    Text("완료했어요!")
                    
                }
                .padding(.horizontal, 100)
                .padding(.vertical, 12)
                .background(.lightYellow)
                .cornerRadius(20)
            }
            .padding(.vertical, 20)
            .background(RoundRectangle_20_Shadow(width: .infinity, height: .infinity, color: Color.yellow))
            .padding(.vertical, 20)
            
            
            
            // 경험치 획득창
            VStack{
                Text("경험치 획득!")
                    .font(.title2)
                    .fontWeight(.semibold)
                Text("+\(result.expEarned) EXP")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.orange)
                CustomExpBar()
                Text("레벨업까지 \(resultViewModel.remainingExp)EXP 남음")
                    .foregroundStyle(.gray)
            }.padding(20)
                .background(RoundRectangle_20_Shadow(width: .infinity, height: .infinity, color: .white))
                .padding(.vertical, 10)
            
            // 활동 기록 창
            VStack{
                Text("📝활동 기록")
                    .font(.title2)
                    .fontWeight(.semibold)
                TextEditor(text: $recordText)
                    .frame(height: 150)
                    .overlay(alignment: .topLeading){
                        Text("오늘 활동은 어땠나요? 오늘 활동에 대한 간단한 메모를 남겨보세요.")
                            .foregroundStyle(recordText.isEmpty ? .gray : .clear)
                            .padding(.top, 10)
                            .padding(.horizontal, 10)
                    }
                    .scrollContentBackground(.hidden)
                    .padding(20)
                    .background(Color.lightGray)
                    .cornerRadius(20)
                
                // 사진 추가 버튼
                Button{
                    // PhotoPicker
                } label: {
                    Text("📸 사진 추가하기")
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity)
                        .padding(20)
                        .background(.white)
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                }
                
                // 활동 저장하기 버튼
                Button{
                    // 서버로 저장 날리기
                    
                } label: {
                    Text("저장하기")
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity)
                        .padding(20)
                        .background(.yellow)
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                }
            }.padding(.horizontal, 20)
                .padding(.vertical, 20)
                .background(RoundRectangle_20_Shadow(width: .infinity, height: .infinity, color: .white))
                .padding(.vertical, 20)
            
            
            // 성장 추카^^
            Text("🌱 매일 조금씩 성장하고 있어요!")
                    .foregroundStyle(.black)
                    .frame(maxWidth: .infinity)
                    .padding(20)
                    .background(.skyBlue)
                    .cornerRadius(20)
            
            // 홈화면 이동
            Button{
                path.removeAll()
            } label: {
                Text("🏠 홈 화면으로 이동")
                    .foregroundStyle(.black)
                    .frame(maxWidth: .infinity)
                    .padding(20)
                    .background(.orange)
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.gray, lineWidth: 1)
                    )
            }
        }
        .navigationBarBackButtonHidden(true) // 기존 네비게이션 바 숨김
        .padding(20)
        .background(LinearGradient(gradient: Gradient(colors: [Color("Light-Yellow"), Color("Light-Pink"), Color("Light-Purple")]), startPoint: .topLeading, endPoint: .bottomTrailing))

        

        
    }
}

#Preview {
//    @Previewable @State var path : [ViewPath] = [ViewPath(type: .activity)]
//    var activityDto = ActivityDto(activityId: "1", activityIconUrl: "💪", activityName: "운동", activityDescription: "건강해져봅시다. 다이어트 좀 합시다.", typeId: 1)
//    ResultView(path: $path, activityDto: activityDto, exp: 50, maxExp: 50, remainingExp: 50)
}


struct CustomExpBar : View{
    var exp: Int = 50
    var maxExp: Int = 200// 현재 레벨 최대 경험치
    var remainingExp: Int = 100// 레벨업까지 남은 경험치
    
    var body: some View{
        GeometryReader { geo in
            // 전체 바
            ZStack(alignment: .leading) {
                // 배경 바 (회색)
                Capsule()
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 20)
                
                // width 계산 필요 아 귀차나
                // 진행 바 (골드)
                Capsule()
                    .fill(.orange)
                    .frame(width: 50, height: 20)
                
            }
        }
        .frame(height: 30)
    }
    
}
