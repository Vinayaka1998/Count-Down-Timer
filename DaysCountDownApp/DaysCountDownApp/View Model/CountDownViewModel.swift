//
//  CountDownViewModel.swift
//  DaysCountDownApp
//
//  Created by Vinayaka on 13/03/24.
//

import Foundation

class CountdownViewModel {
    var timer: Timer?
    var countdownTimer: CountdownTimer
    var onUpdate: ((CountdownTimer) -> Void)?

    //MARK: - Initializers.
    init(initialTime: CountdownTimer) {
        self.countdownTimer = initialTime
    }

    //MARK: - Method to start the Count down of timer after initialized.
    func startCountdown() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.updateTimer()
        }
    }

    //MARK: - Method to update the timer.
    private func updateTimer() {
        if countdownTimer.seconds > 0 {
            countdownTimer.seconds -= 1
        } else {
            if countdownTimer.minutes > 0 {
                countdownTimer.minutes -= 1
                countdownTimer.seconds = 59
            } else {
                if countdownTimer.hours > 0 {
                    countdownTimer.hours -= 1
                    countdownTimer.minutes = 59
                    countdownTimer.seconds = 59
                } else {
                    if countdownTimer.days > 0 {
                        countdownTimer.days -= 1
                        countdownTimer.hours = 23
                        countdownTimer.minutes = 59
                        countdownTimer.seconds = 59
                    } else {
                        timer?.invalidate()
                    }
                }
            }
        }
        onUpdate?(countdownTimer)
    }
}

