//
//  ForecastTableViewCell.swift
//  RacingClimate
//
//  Created by Bernardo Carvalho on 22/02/19.
//  Copyright © 2019 Bernardo Carvalho. All rights reserved.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {

    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setInfo(_ info: Info) {
        if let main = info.main, let weather = info.weather {
            if weather.count > 0, let w = weather.first {
                if let icon = w.icon {
                    let url = URL(string: "https://openweathermap.org/img/w/\(icon).png")
                    
                    self.weatherImageView.kf.setImage(with: url)
                }
                
                self.descriptionLabel.text = (w._description != nil) ? w._description!.capitalized : "Description unavailable"
            }

            self.dateLabel.text = "Date unavailable"
            
            if let dt = info.dt {
                let date = Date(timeIntervalSince1970: TimeInterval(dt))
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd - hh:mm a"
                self.dateLabel.text = dateFormatter.string(from: date)
            }
            
            self.temperatureLabel.text = (main.temp != nil) ? "\(Int(main.temp!)) °F" : "--"
            
        }
    }

}
