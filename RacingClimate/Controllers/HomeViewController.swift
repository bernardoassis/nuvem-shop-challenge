//
//  HomeViewController.swift
//  RacingClimate
//
//  Created by Bernardo Carvalho on 19/02/19.
//  Copyright © 2019 Bernardo Carvalho. All rights reserved.
//

import UIKit
import Kingfisher

class HomeViewController: UIViewController {

    static let FORECAST_SEGUE_IDENTIFIER = "forecast"
    
    var data : [String : Info]? = nil
    var cityNames : [String]!
    var currentIndex = 0
    
    @IBOutlet weak var blurredImageView: UIImageView!
    @IBOutlet weak var weatherImageView: UIImageView!
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadData()
    }
    
    func loadData() {
        self.showLoading()
        
        DataManager.shared.loadCitiesCurrentWeatherData { (weatherData, error) in
            self.dismissLoading()
            
            if (error == nil) {
                self.data = weatherData
            } else {
                self.showAlert("Hey!", "The weather information is unavailable at this moment. Please try again later.")
            }
            
            self.reloadViews()
        }
    }
    
    func reloadViews() {
        if let weatherData = self.data {
            self.cityNames = Array(weatherData.keys)
            self.loadCurrentCityInformation()
        }
    }
    
    func loadCurrentCityInformation() {
        let cityName = self.cityNames[self.currentIndex]
        if let data = self.data, let info = data[cityName] {
            
        }
    }
    
    @IBAction func didClickPreviousButton(_ sender: Any) {
        if let data = self.data, data.count > 0 {
            if (self.currentIndex == 0) {
                self.currentIndex = data.count - 1
            } else {
                self.currentIndex -= 1
            }
            
            self.loadCurrentCityInformation()
        }
    }
    
    
    @IBAction func didClickNextButton(_ sender: Any) {
        if let data = self.data, data.count > 0 {
            if (self.currentIndex == (data.count - 1)) {
                self.currentIndex = 0
            } else {
                self.currentIndex += 1
            }
            
            self.loadCurrentCityInformation()
        }
    }
    
    @IBAction func didClickForecastButton(_ sender: Any) {
        self.performSegue(withIdentifier: HomeViewController.FORECAST_SEGUE_IDENTIFIER, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == HomeViewController.FORECAST_SEGUE_IDENTIFIER) {
            if let forecastViewController = segue.destination as? ForecastTableViewController {
                forecastViewController.city = self.cityNames[self.currentIndex]
            }
        }
    }
    
}

