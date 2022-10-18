//
//  Calculations.swift
//  OBDDashboard
//
//  Created by Артем Кохан on 11.10.2022.
//

import Foundation

private var dtcLetters: [Character] = ["P", "C", "B", "U"]
private var hexArray: [Character] = Array("0123456789ABCDEF")
 
private func performCalculations() {
    
    final String result = fault
    var workingData = ""
    int startIndex = 0
    troubleCodesArray.clear()

    try {
        if (result.contains("43")) {
            workingData = result.replaceAll("^43|[\r\n]43|[\r\n]", "")
        } else if (result.contains("47")) {
            workingData = result.replaceAll("^47|[\r\n]47|[\r\n]", "")
        }
        for(int begin=startIndex; begin < workingData.length(); begin += 4) {
            String dtc = ""
            byte b1 = Utility.hexStringToByteArray(workingData.charAt(begin))
            
            int ch1 = ((b1 & 0xC0) >> 6)
            int ch2 = ((b1 & 0x30) >> 4)
            dtc += dtcLetters[ch1]
            dtc += hexArray[ch2]
            dtc += workingData.substring(begin + 1, begin + 4)

            if (dtc.equals("P0000")) {
                continue
            }
            troubleCodesArray.add(dtc)
        }
    } catch (Exception e) {
        Log.e(TAG, "Error: " + e.getMessage())
    }
}
