//
//  DailyDetail.swift
//  DailyPlan
//
//  Created by 大洋 on 2020/5/2.
//  Copyright © 2020 zhaoyang. All rights reserved.
//

import SwiftUI

struct DailyDetail: View {
    var body: some View {
        ScrollView(.vertical,showsIndicators: false) {
            CustomCellView()
            CustomCellView()
        }
    }
}

struct DailyDetail_Previews: PreviewProvider {
    static var previews: some View {
        DailyDetail()
        
    }
}

struct CustomCellView : View {
    var number = "0"
    var date = "Today"

    var body: some View {
        return HStack {
            Text(number)
                .font(Font.system(size: 20, weight: .medium))
                .padding()
            Spacer()
            Text(date)
                .font(Font.system(size: 20, weight: .regular))
                .foregroundColor(.gray)
                .padding()
        }
    }
}

