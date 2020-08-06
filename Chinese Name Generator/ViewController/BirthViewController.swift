//
//  BirthViewController.swift
//  Chinese Name Generator
//
//  Created by 舅 on 2020/3/23.
//  Copyright © 2020 Joe. All rights reserved.
//

import UIKit
import CDAlertView

class BirthViewController: UIViewController {

    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var nextButton: UIButton!
    
    let zodiacName = ZodiacName()
    let horoscopeName = HoroscopeName()
    
    var userBirthDay = "1990-01-01"
    var userZodiac = ""
    var userHoroscope = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.setValue(UIColor.black, forKeyPath: "textColor")
        nextButton.addCorner(radious: 5)
        horoscopeName.isForeigner = UserData.isForeigner
        zodiacName.isForeigner = UserData.isForeigner
        datePicker.addTarget(self, action: #selector(BirthViewController.caculateZodiac), for: UIControl.Event.valueChanged)
        datePicker.addTarget(self, action: #selector(BirthViewController.caculateHoroscope), for: UIControl.Event.valueChanged)
        caculateZodiac()
        caculateHoroscope()
    }

    @objc func caculateZodiac(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        userBirthDay = dateFormatter.string(from: datePicker.date)
        dateFormatter.dateFormat = "yyyy"
        let year = Int(dateFormatter.string(from: datePicker.date)) ?? 0
        dateFormatter.dateFormat = "MM"
        let month = Int(dateFormatter.string(from: datePicker.date)) ?? 0
        let zodiacNum = year % 12
        if (zodiacNum == 10 && month > 2) || (zodiacNum == 11 && month <= 2){
            updateZodiac(zodiac: zodiacName.monkey)
        }else if (zodiacNum == 1 && month > 2) || (zodiacNum == 2 && month <= 2){
            updateZodiac(zodiac: zodiacName.rooster)
        }else if (zodiacNum == 2 && month > 2) || (zodiacNum == 3 && month <= 2){
            updateZodiac(zodiac: zodiacName.dog)
        }else if (zodiacNum == 3 && month > 2) || (zodiacNum == 4 && month <= 2){
            updateZodiac(zodiac: zodiacName.pig)
        }else if (zodiacNum == 4 && month > 2) || (zodiacNum == 5 && month <= 2){
            updateZodiac(zodiac: zodiacName.rat)
        }else if (zodiacNum == 5 && month > 2) || (zodiacNum == 6 && month <= 2){
            updateZodiac(zodiac: zodiacName.ox)
        }else if (zodiacNum == 6 && month > 2) || (zodiacNum == 7 && month <= 2){
            updateZodiac(zodiac: zodiacName.tiger)
        }else if (zodiacNum == 7 && month > 2) || (zodiacNum == 8 && month <= 2){
            updateZodiac(zodiac: zodiacName.rabbit)
        }else if (zodiacNum == 8 && month > 2) || (zodiacNum == 9 && month <= 2){
            updateZodiac(zodiac: zodiacName.dragon)
        }else if (zodiacNum == 9 && month > 2) || (zodiacNum == 10 && month <= 2){
            updateZodiac(zodiac: zodiacName.snake)
        }else if (zodiacNum == 10 && month > 2) || (zodiacNum == 11 && month <= 2){
            updateZodiac(zodiac: zodiacName.horse)
        }else if (zodiacNum == 11 && month > 2) || (zodiacNum == 0 && month <= 2){
            updateZodiac(zodiac: zodiacName.goat)
        }
    }
    
    @objc func caculateHoroscope(){
        let date = datePicker.date
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "MMdd"
        let day = Int(dateformatter.string(from: date))
        if 120...218 ~= day!{
            updateHoroscope(horoscope: horoscopeName.aquarius)
        }else if 219...320 ~= day!{
            updateHoroscope(horoscope: horoscopeName.pisces)
        }else if 321...420 ~= day!{
            updateHoroscope(horoscope: horoscopeName.aries)
        }else if 421...520 ~= day!{
            updateHoroscope(horoscope: horoscopeName.taurus)
        }else if 521...621 ~= day!{
            updateHoroscope(horoscope: horoscopeName.gemini)
        }else if 622...722 ~= day!{
            updateHoroscope(horoscope: horoscopeName.cancer)
        }else if 723...822 ~= day!{
            updateHoroscope(horoscope: horoscopeName.leo)
        }else if 823...922 ~= day!{
            updateHoroscope(horoscope: horoscopeName.virgo)
        }else if 923...1023 ~= day!{
            updateHoroscope(horoscope: horoscopeName.libra)
        }else if 1023...1122 ~= day!{
            updateHoroscope(horoscope: horoscopeName.scorpio)
        }else if 1123...1221 ~= day!{
            updateHoroscope(horoscope: horoscopeName.sagittarius)
        }else{
            updateHoroscope(horoscope: horoscopeName.capricorn)
        }
    }
    
    func updateZodiac(zodiac:String){
        userZodiac = zodiac
    }
    
    func updateHoroscope(horoscope:String){
        userHoroscope = horoscope
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        switch UserData.isForeigner {
        case true:
            if let image = UIImage(named: zodiacName.imageName) {
                let resizeimage = resizeImage(image: image, targetSize: CGSize(width: 30, height: 30))
                showAlert(title: "Your Chinese Zodiac is \(userZodiac)", message: "Personality Traits: \(zodiacName.info)", image:resizeimage)
            } else {
                performSegue(withIdentifier: "goTraits", sender: self)
            }
        case false:
            if let image = UIImage(named: horoscopeName.imageName) {
                let resizeimage = resizeImage(image: image, targetSize: CGSize(width: 30, height: 30))
                showAlert(title: "寶寶的星座是 \( userHoroscope)", message: "特質: \(horoscopeName.info)", image:resizeimage)
            } else {
                performSegue(withIdentifier: "goTraits", sender: self)
            }
        }
        
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        UserData.setUserData(data: userBirthDay, name: "Birth")
    }
    
    func showAlert(title:String, message:String, image:UIImage) {
        let alert = CDAlertView(title: title, message: message, type: .custom(image:image))
        view.addSubview(alert)
        
        let okAction = CDAlertViewAction(title: "OK", font: nil, textColor: nil, backgroundColor: nil) { (action) -> Bool in
            self.performSegue(withIdentifier: "goTraits", sender: self)
            return true
        }
        alert.add(action: okAction)
        
        var infoText = ""
        switch UserData.isForeigner {
        case true:
            infoText = "More"
            if let font = UIFont(name: "Gill Sans", size: 18) {
                alert.titleFont = font
                alert.messageFont = font.withSize(12)
            }
        case false:
            infoText = "更多"
            if let font = UIFont(name: "jf-openhuninn-1.1", size: 18) {
                alert.titleFont = font
                alert.messageFont = font.withSize(12)
            }
        }
        
        let infoAction = CDAlertViewAction(title: infoText, font: nil, textColor: nil, backgroundColor: nil) { (action) -> Bool in
            self.performSegue(withIdentifier: "goStory", sender: self)
            return true
        }
        alert.add(action: infoAction)
        
        
        alert.isTextFieldHidden = true
        alert.circleFillColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
        
        alert.hideAnimations = { (center, transform, alpha) in
            transform = .identity
            alpha = 0
        }
        alert.show()
    }
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size

        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height

        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }

        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }
    
}
