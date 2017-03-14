//
//  HealthKitHelper.swift
//  GainnTrainn
//
//  Created by Rich Blanchard on 2/19/17.
//  Copyright © 2017 Rich. All rights reserved.
//

import Foundation
import UIKit
import  HealthKit

class HealthKitHelper: NSObject {
    private var readTypesSet: Set<HKObjectType>!
    private var writeTypes: Set<HKObjectType>!
    static let sharedHelper = HealthKitHelper()
    var healthStore:HKHealthStore!
    private override init() {
        super.init()
        
        readTypesSet = Set(arrayLiteral:
            HKObjectType.characteristicType(forIdentifier: .dateOfBirth)!,
                           HKObjectType.characteristicType(forIdentifier: .bloodType)!,
                           HKObjectType.characteristicType(forIdentifier: .biologicalSex)!,
                           HKObjectType.quantityType(forIdentifier: .bodyMass)!,
                           HKObjectType.quantityType(forIdentifier: .height)!,
                           HKObjectType.workoutType()
        )
        writeTypes = Set(arrayLiteral:
            HKObjectType.quantityType(forIdentifier: .bodyMass)!,
                         HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!,
                         HKObjectType.quantityType(forIdentifier: .dietaryEnergyConsumed)!,
                         HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!,
                         HKQuantityType.workoutType()
        )
        
        healthStore = HKHealthStore()
    }
    func getPermission() {
        
        self.healthStore.requestAuthorization(toShare: writeTypes as! Set<HKSampleType>?, read: readTypesSet) { (sucess, error) in
        }
    }
}

