//
//  Sally.swift
//  Pods-SampleLib_Example
//
//  Created by 古山健司 on 2018/12/28.
//

import Foundation
import HealthKit
import RxSwift

public enum HealthKitKError: Error {
    case authorization
}

public class Sally {
    private let healthStore: HKHealthStore
    private let disposeBag = DisposeBag()
    
    public init?() {
        guard HKHealthStore.isHealthDataAvailable() else { return nil }
        healthStore = HKHealthStore()
    }
    
    public func sallyMethod() {
        print("Sally().sallyMethid is called!!")
    }
    
    public func requestAuthorization(identifier: HKQuantityTypeIdentifier) -> Observable<Bool> {
        guard let type = HKObjectType.quantityType(forIdentifier: identifier) else { return Observable.error(HealthKitKError.authorization) }
        return Observable.create({ [weak self] (observer) -> Disposable in
            self?.healthStore.requestAuthorization(toShare: [type], read: [type], completion: { (success, error) in
                if let error = error {
                    observer.onError(error)
                }
                
                if success {
                    observer.onNext(success)
                    observer.onCompleted()
                }
            })
            return Disposables.create()
        })
    }
    
    public func fetchStepCount() -> Observable<Double> {
        return Observable.create({ [weak self] (observer) -> Disposable in
            let stepCountType = HKQuantityType.quantityType(forIdentifier: .stepCount)
            let now = Date()
            let cal = Calendar(identifier: .gregorian)
            let newDate = cal.startOfDay(for: now)

            let predicate = HKQuery.predicateForSamples(withStart: newDate, end: now, options: .strictStartDate)
            var interval = DateComponents()
            interval.day = 1

            if let type = stepCountType {
                let query = HKStatisticsCollectionQuery(quantityType: type, quantitySamplePredicate: predicate, options: [.cumulativeSum], anchorDate: newDate, intervalComponents: interval)

                query.initialResultsHandler = { query, result, error in
                    if let error = error {
                        observer.onError(error)
                        return
                    }

                    if let myResult = result {
                        myResult.enumerateStatistics(from: newDate, to: now, with: { (statictics, stop) in
                            if let quantity = statictics.sumQuantity() {
                                let steps = quantity.doubleValue(for: HKUnit.count())
                                observer.onNext(steps)
                                observer.onCompleted()
                            }
                        })
                    }
                }
                self?.healthStore.execute(query)
            } else {
                observer.onError(HealthKitKError.authorization)
            }
            return Disposables.create()
        })
    }
    
}
