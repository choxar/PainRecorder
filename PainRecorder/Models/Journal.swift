//
//  Journal.swift
//  PainRecorder
//
//  Created by elina.zambere on 23/02/2021.
//

import Foundation

class journal {
    
    var date: String
    var time: String
    var painType: String
    var painPower: String
    var notes: String
    
    init(date: String, time: String, painType: String, painPower: String, notes: String = "") {
        
        self.date = date
        self.time = time
        self.painType = painType
        self.painPower = painPower
        self.notes = notes
        
    }
    
    convenience init() {
        
        self.init(date: "", time: "", painType: "", painPower: "", notes: "")
        
    }
    
}
