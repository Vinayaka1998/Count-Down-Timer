//
//  ViewController.swift
//  DaysCountDownApp
//
//  Created by Vinayaka on 13/03/24.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: Outlets.
    @IBOutlet weak var daysView: CountDownView!
    @IBOutlet weak var hoursView: CountDownView!
    @IBOutlet weak var minutesView: CountDownView!
    @IBOutlet weak var secondsView: CountDownView!
    
    var countdownViewModel: CountdownViewModel!
    var timerData: CountdownTimer?
    var startDate: Date?
    
    //MARK: - Life Cycles.
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchTheTimeAfterInitialized()
        startTimer()
        addObserver()
    }
    
    //MARK: - Method to add notification observer when app will go background or terminates to save the timer data.
    func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(saveTimerData), name: UIApplication.willResignActiveNotification, object: nil)
    }
    
    //MARK: - Method to fetch the data if already stored, else it will initialize.
    func fetchTheTimeAfterInitialized() {
        if let storedTimerData = UserDefaults.standard.data(forKey: UserDefaultConstants.countDownTimer),
           let savedStartDate = UserDefaults.standard.object(forKey: UserDefaultConstants.startDate) as? Date {
            do {
                let decoder = JSONDecoder()
                timerData = try decoder.decode(CountdownTimer.self, from: storedTimerData)
                startDate = savedStartDate
                updateTimer()
            } catch {
                print("Error decoding timer data: \(error)")
                initializeTimer()
            }
        } else {
            initializeTimer()
        }
    }
    
    //MARK: - Method to save data.
    @objc func saveTimerData() {
        do {
            let encoder = JSONEncoder()
            let timerData = try encoder.encode(self.timerData)
            UserDefaults.standard.set(timerData, forKey: UserDefaultConstants.countDownTimer)
            UserDefaults.standard.set(startDate, forKey: UserDefaultConstants.startDate)
        } catch {
            print("Error encoding timer data: \(error)")
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: - Method to initiliaze the timer.
    func initializeTimer() {
        timerData = CountdownTimer(days: 10, hours: 8, minutes: 33, seconds: 23)
        startDate = Date()
    }
    
    //MARK: - Method to update the timer
    @objc func updateTimer() {
        guard let startDate = startDate, let timerData = timerData else { return }
        let elapsedTime = Date().timeIntervalSince(startDate)
        let remainingTime = calculateRemainingTime(initialTime: timerData, elapsedTime: elapsedTime)
        updateUI(with: remainingTime)
    }
    
    //MARK: - Method to start the timer.
    func startTimer() {
        let timer = Timer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        RunLoop.main.add(timer, forMode: .common)
    }
    
    //MARK: - Method to update the elements of UI.
    func updateUI(with timerData: CountdownTimer) {
        daysView.countDownLabel.text = String(format: "%02d", timerData.days)
        hoursView.countDownLabel.text = String(format: "%02d", timerData.hours)
        minutesView.countDownLabel.text = String(format: "%02d", timerData.minutes)
        secondsView.countDownLabel.text = String(format: "%02d", timerData.seconds)
    }
    
    //MARK: - Method to calculate the remaining time after launch again.
    func calculateRemainingTime(initialTime: CountdownTimer, elapsedTime: TimeInterval) -> CountdownTimer {
        let totalSeconds = initialTime.days * 24 * 3600 + initialTime.hours * 3600 + initialTime.minutes * 60 + initialTime.seconds
        let remainingSeconds = max(0, totalSeconds - Int(elapsedTime))
        
        let days = remainingSeconds / (24 * 3600)
        let hours = (remainingSeconds % (24 * 3600)) / 3600
        let minutes = (remainingSeconds % 3600) / 60
        let seconds = remainingSeconds % 60
        
        return CountdownTimer(days: days, hours: hours, minutes: minutes, seconds: seconds)
    }
}

//MARK: - For flipping the view from middile not working as per requirement. We can use like ourView.openFromMiddleToTop()

extension UIView {
    func openFromMiddleToTop() {
        let oldFrame = self.frame
        let newFrame = CGRect(x: oldFrame.origin.x, y: oldFrame.origin.y - oldFrame.height / 2, width: oldFrame.width, height: oldFrame.height * 2)
        
        UIView.animate(withDuration: 0.25, delay: 0, options: [.curveEaseInOut], animations: {
            self.frame = newFrame
        }, completion: nil)
    }
}
