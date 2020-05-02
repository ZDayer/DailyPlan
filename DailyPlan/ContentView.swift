//
//  ContentView.swift
//  DailyPlan
//
//  Created by zhaoyang on 2020/4/30.
//  Copyright © 2020 zhaoyang. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
         ClickView()
            .frame(width: 250, height: 250)
            .background(Color("bgColor"))
            .cornerRadius(125)
            .onTapGesture {
                let random = randomDailyNumber()
                print(random)
        }
        
//        NavigationView {
//            NavigationLink(destination: DailyDetail()) {
//                VStack {
//                    ClickView()
//                        .frame(width: 250, height: 250)
//                        .background(Color("bgColor"))
//                        .cornerRadius(125)
//                }
//            }
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ClickView: View {
    var textContent = "选取今日数字"
    var body: some View {
        Text(textContent)
            .foregroundColor(.white)
            .font(.largeTitle)
    }
}

func randomDailyNumber() -> Int {
    let number = arc4random()%365+1
    return Int(number)
}
