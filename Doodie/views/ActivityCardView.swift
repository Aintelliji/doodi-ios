//
//  ActivityCardView.swift
//  Doodie
//
//  Created by 수진 on 10/12/25.
//

import SwiftUI

struct ActivityCardView: View {
    
    var activityIcon: String
    var activityName: String
    var cardBackgroundColor: Color
    
    var body: some View {
        VStack{
            Text(activityIcon)
                .font(.title)
            Text(activityName)
                .font(.title2)
        }.background(RoundedRectangle(cornerRadius: 24).fill(cardBackgroundColor)
            .frame(width: 150, height: 150))
        .shadow(radius: 10)
    }
}

#Preview {
    ActivityCardView(activityIcon: "dd", activityName:"dd", cardBackgroundColor: Color.blue)
}
