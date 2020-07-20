//
//  DropDown.swift
//  FinalProject
//
//  Created by user167402 on 7/13/20.
//  Copyright © 2020 user167402. All rights reserved.
//

import SwiftUI

struct DropDown: View {
    var body: some View {
        DropDownList()
    }
}

struct DropDown_Previews: PreviewProvider {
    static var previews: some View {
        DropDown()
    }
}


struct DropDownList : View {
    @State var expand = false
    var body : some View {
        VStack {
            HStack {
                Text("TEST").fontWeight(.heavy)
                Image(systemName: "down-chevron").resizable().frame(width: 10, height: 10)
            }.onTapGesture {
                self.expand.toggle()
            }
            Button(action: {
                
            }) {
                Text("1").padding()
            }.foregroundColor(.black)
            
            Button(action: {
                
            }) {
                Text("2").padding()
            }.foregroundColor(.black)
            
        }.frame(height: expand ? 500 : 100).cornerRadius(20).padding(7).background(expand ? Color.green : Color.blue)
    }
    
}
