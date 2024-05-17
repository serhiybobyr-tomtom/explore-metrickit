//
//  MetricReporter.swift
//  ExploreMetricKit
//
//  Created by Serhiy Bobyr on 17/05/2024.
//

import MetricKit

final class MetricReporter: NSObject, MXMetricManagerSubscriber {
    func setup() {
        MXMetricManager.shared.add(self)
    }

    func didReceive(_ payloads: [MXMetricPayload]) {
        print("------------------------------------------------------------------------------------------")
        if #available(iOS 14.0, *) {
            let applicationExitMetrics = payloads
                .compactMap({$0.applicationExitMetrics})
            for applicationExitMetric in applicationExitMetrics {
                print("ForegroundExitData:")
                print("\tcumulativeNormalAppExitCount: \(applicationExitMetric.foregroundExitData.cumulativeNormalAppExitCount)")
                print("\tcumulativeMemoryResourceLimitExitCount: \(applicationExitMetric.foregroundExitData.cumulativeMemoryResourceLimitExitCount)")
                print("\tcumulativeBadAccessExitCount: \(applicationExitMetric.foregroundExitData.cumulativeBadAccessExitCount)")
                print("\tcumulativeAbnormalExitCount: \(applicationExitMetric.foregroundExitData.cumulativeAbnormalExitCount)")
                print("\tcumulativeIllegalInstructionExitCount: \(applicationExitMetric.foregroundExitData.cumulativeIllegalInstructionExitCount)")
                print("\tcumulativeAppWatchdogExitCount: \(applicationExitMetric.foregroundExitData.cumulativeAppWatchdogExitCount)")
                print("BackgroundExitData:")
                print("\tcumulativeNormalAppExitCount: \(applicationExitMetric.backgroundExitData.cumulativeNormalAppExitCount)")
                print("\tcumulativeMemoryResourceLimitExitCount: \(applicationExitMetric.backgroundExitData.cumulativeMemoryResourceLimitExitCount)")
                print("\tcumulativeCPUResourceLimitExitCount: \(applicationExitMetric.backgroundExitData.cumulativeCPUResourceLimitExitCount)")
                print("\tcumulativeMemoryPressureExitCount: \(applicationExitMetric.backgroundExitData.cumulativeMemoryPressureExitCount)")
                print("\tcumulativeBadAccessExitCount: \(applicationExitMetric.backgroundExitData.cumulativeBadAccessExitCount)")
                print("\tcumulativeAbnormalExitCount: \(applicationExitMetric.backgroundExitData.cumulativeAbnormalExitCount)")
                print("\tcumulativeIllegalInstructionExitCount: \(applicationExitMetric.backgroundExitData.cumulativeIllegalInstructionExitCount)")
                print("\tcumulativeAppWatchdogExitCount: \(applicationExitMetric.backgroundExitData.cumulativeAppWatchdogExitCount)")
                print("\tcumulativeSuspendedWithLockedFileExitCount: \(applicationExitMetric.backgroundExitData.cumulativeSuspendedWithLockedFileExitCount)")
                print("\tcumulativeBackgroundTaskAssertionTimeoutExitCount: \(applicationExitMetric.backgroundExitData.cumulativeBackgroundTaskAssertionTimeoutExitCount)")
            }
            print("------------------------------------------------------------------------------------------")
        }
    }

    @available(iOS 14.0, *)
    func didReceive(_ payloads: [MXDiagnosticPayload]) {
        print("------------------------------------------------------------------------------------------")
        let crashDiagnostics = payloads
            .compactMap({ $0.crashDiagnostics })
            .flatMap { $0 }
        for crashDiagnostic in crashDiagnostics {
            let callStackTree = crashDiagnostic.callStackTree.jsonRepresentation()

            print(String(bytes: callStackTree, encoding: .utf8)!)

            if let terminationReason = crashDiagnostic.terminationReason {
                print("terminationReason: \(terminationReason)")
            }
            if let exceptionType = crashDiagnostic.exceptionType {
                print("exceptionType: \(exceptionType)")
            }
            if let exceptionCode = crashDiagnostic.exceptionCode {
                print("exceptionCode: \(exceptionCode)")
            }
            if let signal = crashDiagnostic.signal {
                print("signal: \(signal)")
            }
        }
        print("------------------------------------------------------------------------------------------")
    }
}
