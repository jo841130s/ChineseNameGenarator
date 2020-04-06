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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.addTarget(self, action: #selector(BirthViewController.caculateZodiac), for: UIControl.Event.valueChanged)
        datePicker.addTarget(self, action: #selector(BirthViewController.caculateHoroscope), for: UIControl.Event.valueChanged)
        caculateZodiac()
        caculateHoroscope()
    }

    @objc func caculateZodiac(){
        let dateLong = "\(datePicker.date)"
        let date = Int(dateLong.prefix(4))!
        let zodiac = date % 12
        if zodiac == 0{
            updateZodiac(zodiac: "Monkey")
        }else if zodiac == 1{
            updateZodiac(zodiac: "Rooster")
        }else if zodiac == 2{
            updateZodiac(zodiac: "Dog")
        }else if zodiac == 3{
            updateZodiac(zodiac: "Pig")
        }else if zodiac == 4{
            updateZodiac(zodiac: "Rat")
        }else if zodiac == 5{
            updateZodiac(zodiac: "Ox")
        }else if zodiac == 6{
            updateZodiac(zodiac: "Tiger")
        }else if zodiac == 7{
            updateZodiac(zodiac: "Rabbit")
        }else if zodiac == 8{
            updateZodiac(zodiac: "Dragon")
        }else if zodiac == 9{
            updateZodiac(zodiac: "Snake")
        }else if zodiac == 10{
            updateZodiac(zodiac: "Horse")
        }else if zodiac == 11{
            updateZodiac(zodiac: "Goat")
        }
    }
    
    @objc func caculateHoroscope(){
        let date = datePicker.date
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "MMdd"
        let day = Int( dateformatter.string(from: date))
        if 120...218 ~= day!{
            updateHoroscope(horoscope: "Aquarius")
        }else if 219...320 ~= day!{
            updateHoroscope(horoscope: "Pisces")
        }else if 321...420 ~= day!{
            updateHoroscope(horoscope: "Aries")
        }else if 421...520 ~= day!{
            updateHoroscope(horoscope: "Taurus")
        }else if 521...621 ~= day!{
            updateHoroscope(horoscope: "Gemini")
        }else if 622...722 ~= day!{
            updateHoroscope(horoscope: "Cancer")
        }else if 723...822 ~= day!{
            updateHoroscope(horoscope: "Leo")
        }else if 823...922 ~= day!{
            updateHoroscope(horoscope: "Virgo")
        }else if 923...1023 ~= day!{
            updateHoroscope(horoscope: "Libra")
        }else if 1023...1122 ~= day!{
            updateHoroscope(horoscope: "Scorpio")
        }else if 1123...1221 ~= day!{
            updateHoroscope(horoscope: "Sagittarius")
        }else{
            updateHoroscope(horoscope: "Capricorn")
        }
    }
    
    func userBirthDay()->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: datePicker.date)
    }
    
    func updateZodiac(zodiac:String){
        chineseZodiacLabel.text = zodiac
        chineseZodiacImageView.image = UIImage(named: zodiac)
    }
    
    func updateHoroscope(horoscope:String){
        horoscopeLabel.text = horoscope
        horoscopeImageView.image = UIImage(named: horoscope)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        UserData().setUserData(data: userBirthDay(), name: "Birth")
    }
    
}
