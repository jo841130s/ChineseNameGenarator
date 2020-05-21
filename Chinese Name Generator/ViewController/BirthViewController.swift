//
//  BirthViewController.swift
//  Chinese Name Generator
//
//  Created by 舅 on 2020/3/23.
//  Copyright © 2020 Joe. All rights reserved.
//

import UIKit

class BirthViewController: UIViewController {

    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var chineseZodiacLabel: UILabel!
    @IBOutlet var chineseZodiacImageView: UIImageView!
    @IBOutlet var horoscopeLabel: UILabel!
    @IBOutlet var horoscopeImageView: UIImageView!
    
    let zodiacName = ZodiacName()
    let horoscopeName = HoroscopeName()
    
    let isForeigner = UserDefaults.standard.bool(forKey: "isForeigner")
    
    var userBirthDay = "1990-01-01"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        horoscopeName.isForeigner = isForeigner
        zodiacName.isForeigner = isForeigner
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
        }else if (zodiacNum == 11 && month > 2) || (zodiacNum == 0 && month <= 2){
            updateZodiac(zodiac: zodiacName.rooster)
        }else if (zodiacNum == 0 && month > 2) || (zodiacNum == 1 && month <= 2){
            updateZodiac(zodiac: zodiacName.dog)
        }else if (zodiacNum == 1 && month > 2) || (zodiacNum == 2 && month <= 2){
            updateZodiac(zodiac: zodiacName.pig)
        }else if (zodiacNum == 2 && month > 2) || (zodiacNum == 3 && month <= 2){
            updateZodiac(zodiac: zodiacName.rat)
        }else if (zodiacNum == 3 && month > 2) || (zodiacNum == 4 && month <= 2){
            updateZodiac(zodiac: zodiacName.ox)
        }else if (zodiacNum == 4 && month > 2) || (zodiacNum == 5 && month <= 2){
            updateZodiac(zodiac: zodiacName.tiger)
        }else if (zodiacNum == 5 && month > 2) || (zodiacNum == 6 && month <= 2){
            updateZodiac(zodiac: zodiacName.rabbit)
        }else if (zodiacNum == 6 && month > 2) || (zodiacNum == 7 && month <= 2){
            updateZodiac(zodiac: zodiacName.dragon)
        }else if (zodiacNum == 7 && month > 2) || (zodiacNum == 8 && month <= 2){
            updateZodiac(zodiac: zodiacName.snake)
        }else if (zodiacNum == 8 && month > 2) || (zodiacNum == 9 && month <= 2){
            updateZodiac(zodiac: zodiacName.horse)
        }else if (zodiacNum == 9 && month > 2) || (zodiacNum == 10 && month <= 2){
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
        chineseZodiacLabel.text = zodiac
        chineseZodiacImageView.image = UIImage(named: zodiacName.imageName)
    }
    
    func updateHoroscope(horoscope:String){
        horoscopeLabel.text = horoscope
        horoscopeImageView.image = UIImage(named: horoscopeName.imageName)
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        UserData().setUserData(data: userBirthDay, name: "Birth")
    }
    
}
