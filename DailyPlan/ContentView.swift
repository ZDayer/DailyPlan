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
        .gesture(
            TapGesture().onEnded({
                print("click into another page")
            })
            
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ClickView: View {
    var body: some View {
        Text("选取今日数字")
            .foregroundColor(.white)
            .font(.largeTitle)
    }
}
