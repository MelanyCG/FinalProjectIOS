//
//  PickerListNames.swift
//  FinalProject
//
//  Created by user167402 on 7/12/20.
//  Copyright © 2020 user167402. All rights reserved.
//

import SwiftUI

var groupId: String = ""


struct PickerListNames: View {
    var body: some View {
        NavigationView {
            Form {
                Text("Select your list")
            }
        }
    }
}

struct PickerListNames_Previews: PreviewProvider {
    static var previews: some View {
        PickerListNames()
    }
}
