//
//  StatisticsViewController.swift
//  PainRecorder
//
//  Created by elina.zambere on 23/02/2021.
//

import SwiftUI

struct StatisticsViewController: View {
    
    @State var pickerSelectedItem = 0
    
    var body: some View {
        
        ZStack {
            
            VStack {
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                    Picker(selection: $pickerSelectedItem, label: Text("")) {
                        
                        Text("Pain").tag(0)
                        Text("Training").tag(1)
                        
                    }.pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal,25)
      
    }
}
}

}
