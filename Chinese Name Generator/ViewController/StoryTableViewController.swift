//
//  ZodiacStoryTableViewController.swift
//  Chinese Name Generator
//
//  Created by 舅 on 2020/5/23.
//  Copyright © 2020 Joe. All rights reserved.
//

import UIKit

class StoryTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var nextButton: UIButton!
    
    let isForeigner = UserDefaults.standard.bool(forKey: "isForeigner")
    
    let zodiacStory = ["Long, long ago, there was no Chinese zodiac. The Jade Emperor wanted to select 12 animals to be his guards. He sent an immortal being into man's world to spread the message that the earlier one went through the Heavenly Gate, the better the rank one would have.","The next day, animals set off towards the Heavenly Gate. Rat got up very early. On his way to the gate, he encountered a river. He had to stop there, owing to the swift current. After waiting a long time, Rat noticed Ox about to cross the river and swiftly jumped into Ox's ear.","The diligent Ox did not mind at all and simply continued. After crossing the river, he raced towards the palace of the Jade Emperor. Suddenly, Rat jumped out of Ox's ear and dashed to the feet of the Emperor. Rat won first place and Ox was second.","Tiger and Rabbit came third and fourth because both are fast and competitive, but Tiger was faster. ","Good-looking Dragon was fifth and was immediately noticed by the Jade Emperor, who said Dragon's son could be sixth. But Dragon's son didn't come with him that day. Just then, Snake came forward and said Dragon was his adoptive father; so Snake ranked sixth.","Horse and Goat arrived. They were very kind and modest and each let the other go first. The Jade Emperor saw how polite they were and ranked them seventh and eighth.","Monkey had fallen well behind. But he jumped between trees and stones, and caught up to be ninth. Last were Rooster, Dog, and Pig.","These 12 animals became guards of the Heavenly Gate."]
    
    let horoscopeName = HoroscopeName()
    
    var horoscopes : [String] = []
    
    var horoscopeStories = ["赫貝是宙斯的女兒，在天庭中負責招待和倒酒的任務，但後來她出嫁了，所以待酒的任務一直沒有人接任，後來宙斯想到了特洛伊王國的王子卡尼米，卡尼米是一個美少年，他的美在諸神中很出名，宙斯想想請卡尼米擔任此一工作，但生性風流的卡尼米不肯，於是宙斯一怒之下就變成一隻鷹，親自去接卡尼米到天上，但卡尼米故意在倒酒時狀況連連，並藉機逃脫，但宙斯怎會放過他，又將他捉回，並從此住在天上擔任行待者了。宙斯將這少年和水瓶一起放在天上，成為水瓶座。","這也是和魔羯座有關的神話，牧神潘恩吹奏笛子引來了怪物，眾神紛紛化為動物逃脫，而這時漂亮的女神維納斯和她長不大的孩子愛神邱比特正好也一起在河邊散步，被 這可怕的怪物所攻擊，兩個人吃了一驚，於是趕緊逃命，而跳進河中變成兩條魚逃走，維納斯為了怕邱比特被河水沖走，於是用絲帶綁住自己和兒子的尾巴，以免失散。他們保持那個形狀，升到天上，變成雙魚座。","費里索和妹妹海莉，遭到父親希臘國王新娶的繼母所憎恨，繼母故意讓全國造成饑荒，再嫁禍於費里索，於是可憐的兄妹們的生命有了危險。當兄妹要被送入祭壇時，這時天神漢彌爾聽到了生母的請求，派了一隻長翅膀的金黃色山羊，去幫助這對兄妹。山羊救出這對兄妹並把二人背在背上，全速飛走．．．誰知飛得太快，妹妹竟然摔落海中～～山羊安慰、鼓勵費里索，並把他送到土耳其。還有另一個說法是費里索為了感謝自己被山羊所救贖，便將白羊獻給了眾神之王宙斯，宙斯則將白羊放入天上，即成為了白羊座的星座傳說。","腓尼基的國王，有位漂亮的獨生女名叫歐羅巴。天神宙斯在一個初春的早晨，看到了歐羅巴和一群少女們在湖邊嬉戲，便深深被她所吸引，同時淘氣的邱比特也射出了愛神的箭，讓宙斯瘋狂愛上歐羅巴。宙斯便變身成為一隻漂亮又溫馴的白色公牛，出現於歐羅巴的面前，不明究裏的歐羅巴，忍不住坐在牛背上。這時，公牛立刻跑進地中海。當他進入海中時，海精們也高興的開道並且高奏結婚進行曲，於是兩人就來到宙斯的出生地克里特島，宙斯恢復原來的樣子，和她結婚。宙斯比身為的白色公牛，便升到天上，變成金牛座。","波爾克斯和卡斯特是雙胞胎，在一次鬥爭中，卡斯特不幸被殺死。波爾克斯向他們的父親，即是眾神之王宙斯請求，希望能讓卡斯特復活，甚至願用自己的生命來代替。於是宙斯被他的真情所感動，讓波爾克斯的生命分一半給卡斯特，半生的時間兩人共同生活在天堂的神殿，另外半生則生活在地獄裡。古羅馬軍人崇拜這種義勇精神，尊奉雙子座為勝利之神，也有人稱之為人類之神，同時也是水手的守護者。","武仙座海克力士是宙斯的私生子，因此宙斯的太太朱諾很不喜歡他，於是便讓海克力士失了理智，親手殺了太太及孩子，等他清醒後，就決定請求馬西尼國王收他為奴，國王便交予他十二項不可能的艱難任務，讓以苦行的方式來清洗自己的罪，但朱諾仍不放過他，下了許多詛咒，使他經歷了很多苦難。其中之一是殺死九頭水蛇，牠是每砍掉一個頭就會馬上再長出兩個頭的可怕怪物。海克力士快要制服水蛇時，朱諾又差遣一隻后蟹，幫助水蛇。但是，巨蟹雖然要救助水蛇，卻被海克力士一腳踩死，最後終於完成任務。宙斯為了紀念海克力士的勇敢與朱諾的狠毒，就把這隻巨蟹帶到天上，變成星座。","武仙座海克力士在星座神話中是個悲劇英雄，面對許多苦難都能一一克服，最後仍以自焚結束豪壯卻不快樂的一生。宙斯神宮附近森林裏，住著一隻凶猛的獅子，具有力槍不入的堅韌皮革。海克力士的十二項任務中有一項便是奉命他去殺死這隻獅子，經過一番博鬥後，海克力士的刀棒都斷了，最後他徒手捏住獅子的咽喉，才使牠斷了氣，海克力士也剝下這件刀槍不入的獅皮做為戰袍，獅子頭做為頭盔，光榮的回到馬西尼，而其父宙斯便讓這頭巨獅升上天空中成為了獅子座。","埃及人認為處女座是一個少女，因為她哥哥被慘殺了，哭得死去活來，淚水使尼羅河暴漲，天神感於這種手足之情，將她和尼羅河提到天上，成了室女座和波江座。希臘人則說處女座是掌管正義和收穫的女神，因為她的女兒被宙斯的哥哥地獄冥府之王所強擄為妻，所以悲傷痛苦，讓大地一片荒蕪，後來經過太陽神阿波羅的協調，及宙斯的出面處理，終於找回愛女，但愛女在設計下吃了四顆石榴，註定每年要回地獄四個月，因此人間才開始有了分明的春夏秋冬四季，宙斯也把她升到天上變為處女座。","正義女神阿斯特莉帶著天平，每天忙著評量人間的善惡是非。但是人心由原本的單純質樸，到後來的貪婪墮落，每天都不斷發生爭執，甚至引發戰爭，阿斯特莉還留在地上，苦口婆心想說服人們遵守道德，希望地上能夠回復到以前善良的時代。不過人們很不再也不願去聽她的勸告，不斷戰爭。最終失望的她也放棄了徒勞無功的努力，失望的帶著天平回到天上。天平放在她腳邊，就成了天秤座。","海神的兒子奧利恩是個英俊又擅於狩獵的人，他愛上了西奧斯國王的女兒美洛珀，為了表示他的愛，就將島上所有的野獸都捕捉來獻給她，但國王仍不同意把女兒嫁給他，在一次酒醉後，奧利里侵犯了美洛珀，國王一氣之下命令酒神使其酒碎不醒，並挖去他的雙眼，後來奧利里請求太陽神恢復他的視力，逃到了克里特島，成為狩獵神里那的手下，但里那因嫉妒黎明女神愛上了奧利里，便殺了他，於是宙斯將其放於天空成為獵戶座。\n而因為獵戶座奧利恩之前曾向人說天底下的動物沒有不怕他的，這話引起天后朱諾的不高興，她是個大醋桶，就派一隻毒蝎去刺殺他，毒蝎尾巴的毒鉤非常厲害，又善於埋伏，正是獵戶座的剋星，奧利恩當然特別提防這隻蝎子，即使成為星座，奧利恩仍一直逃避這隻毒蝎的追擊，只要天蝎座出現天空，獵戶座趕忙西沉，天蝎座西沉，獵戶座才又溜回天上，這便是這兩個星座永不相遇的故事。","地球上有一群半人半馬的群族，稱為山杜爾群，他們凶猛殘暴，如同蠻荒之戰，唯有其中一位齊倫不同於眾，他精通武藝，是一個射術高強，非常有名氣的神箭手，同時他也對於音樂、醫學、預言等，他都有獨特的心得。尤其他以擁有長生不老和智慧高超而聞名。但齊倫卻在一次的鬥爭中不幸被誤傷，他祈求能以一死來解脫這種永生的痛苦，於是天神宙斯將他引到天上去，變成了星座。","牧神潘恩長的十分奇持，有著山羊角，山羊蹄及山羊鬍，他愛上了仙女希林克絲，但她卻嫌她外表醜陋而將自己化為蘆葦避開他，沒想到潘恩卻用這蘆葦做為笛子，到處吹奏美妙的笛聲，某天，宙斯帶領著眾神，在河畔飲酒。牧神潘恩也吹奏著他最拿手的牧笛，所有的神都盡情地歡鬧，沒想到笛聲突然驚動了宙斯的死對頭怪物出現攻擊眾神，於是大家在驚惶之中，變為各式各樣的動物逃走了。潘恩在情急之下，往尼羅河中跳躍下去，但是，因為河水不夠深，加上他太過緊張，所以使得他的下半身浸入水中，順利的化為魚的形態，上半身卻仍保持著原來的山羊形態。這奇怪的山羊就叫摩羯座，也稱之為山羊座。"]
    
    var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.addCorner(radious: 5)
        horoscopes = [horoscopeName.aquarius,horoscopeName.pisces,horoscopeName.aries,horoscopeName.taurus,horoscopeName.gemini,horoscopeName.cancer,horoscopeName.leo,horoscopeName.virgo,horoscopeName.libra,horoscopeName.scorpio,horoscopeName.sagittarius,horoscopeName.capricorn]
        tableView.delegate = self
        tableView.dataSource = self
    }

    @IBAction func backButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Table view data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch isForeigner {
        case true:
            return zodiacStory.count
        case false:
            return horoscopes.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        switch isForeigner {
        case true:
            let attributedString = NSMutableAttributedString(string: zodiacStory[indexPath.row])
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 10
            attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
            cell.textLabel?.attributedText = attributedString
            if let font = UIFont(name: "Centaur", size: 18) {
                cell.textLabel?.font = font
            }
        case false:
            cell.textLabel?.text = horoscopes[indexPath.row]
            cell.textLabel?.font = UIFont(name: "圓體-簡 細體", size: 24)
            cell.accessoryType = .disclosureIndicator
        }
        
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch isForeigner {
        case true:
            break
        case false:
            selectedIndex = indexPath.row
            performSegue(withIdentifier: "goHoroscopeStory", sender: self)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? HoroscopeStoryViewController {
            vc.viewTitle = horoscopes[selectedIndex]
            vc.cellText = horoscopeStories[selectedIndex]
        }
    }

}
