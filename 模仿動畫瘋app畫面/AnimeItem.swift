import Foundation

struct AnimeItem: Identifiable {
    let id = UUID()
    let title: String
    let imageName: String
    let dateTime: String
    let episode: String
    let views: String
    let isVIPOnly: Bool
}

extension AnimeItem {
    static let sampleData: [AnimeItem] = [
        AnimeItem(
            title: "你行你上！",
            imageName: "anime_01",
            dateTime: "10/16 (五) 00:58",
            episode: "第2集",
            views: "2.9萬",
            isVIPOnly: false
        ),
        AnimeItem(
            title: "你剛剛偷看我的手機？你講很久！",
            imageName: "anime_02",
            dateTime: "10/16 (五) 00:15",
            episode: "第3集",
            views: "1.5萬",
            isVIPOnly: false
        ),
        AnimeItem(
            title: "熱愛工作",
            imageName: "anime_03",
            dateTime: "10/16 (五) 00:00",
            episode: "第2集",
            views: "1.2萬",
            isVIPOnly: false
        ),
        AnimeItem(
            title: "心靈雞湯",
            imageName: "anime_04",
            dateTime: "10/15 (四) 23:56",
            episode: "第16集",
            views: "140.7萬",
            isVIPOnly: false
        ),
        AnimeItem(
            title: "我好興奮呀！我好興奮呀！",
            imageName: "anime_05",
            dateTime: "10/15 (四) 20:30",
            episode: "第3集",
            views: "29.1萬",
            isVIPOnly: false
        ),
        AnimeItem(
            title: "你看看你",
            imageName: "anime_06",
            dateTime: "10/15 (四) 01:15",
            episode: "第14集",
            views: "5.2萬",
            isVIPOnly: false
        ),
        AnimeItem(
            title: "我沒事啊！期末報告 生活作息 做家事 截止日期",
            imageName: "anime_07",
            dateTime: "10/15 (四) 01:00",
            episode: "第2集",
            views: "1.3萬",
            isVIPOnly: false
        ),
        AnimeItem(
            title: "阿是要我講幾次",
            imageName: "anime_08",
            dateTime: "10/15 (四) 00:30",
            episode: "第3集",
            views: "2.4萬",
            isVIPOnly: false
        ),
        AnimeItem(
            title: "工作是為了什麼？",
            imageName: "anime_09",
            dateTime: "10/14 (三) 23:30",
            episode: "第3集",
            views: "16.1萬",
            isVIPOnly: false
        ),
        AnimeItem(
            title: "我有在聽",
            imageName: "anime_10",
            dateTime: "10/14 (三) 23:15",
            episode: "第2集",
            views: "2.8萬",
            isVIPOnly: false
        ),
        AnimeItem(
            title: "你是在哭喔？（哩洗勒靠喔？）",
            imageName: "anime_11",
            dateTime: "10/14 (三) 21:30",
            episode: "第2集",
            views: "2.5萬",
            isVIPOnly: false
        ),
        AnimeItem(
            title: "你不要過來啊！",
            imageName: "anime_12",
            dateTime: "10/14 (三) 21:00",
            episode: "第2集",
            views: "7.8萬",
            isVIPOnly: false
        ),
        AnimeItem(
            title: "我發誓不再逃避訓練 如果逃避我就再發誓！",
            imageName: "anime_13",
            dateTime: "10/14 (三) 21:00",
            episode: "第2集",
            views: "6萬",
            isVIPOnly: false
        ),
        AnimeItem(
            title: "我就懶",
            imageName: "anime_14",
            dateTime: "10/14 (三) 02:15",
            episode: "第1集",
            views: "8208",
            isVIPOnly: false
        ),
        AnimeItem(
            title: "我到底看了什麼？",
            imageName: "anime_15",
            dateTime: "10/14 (三) 00:30",
            episode: "第14集",
            views: "57.3萬",
            isVIPOnly: false
        ),
        AnimeItem(
            title: "不管他嗑了什麼 都給我來一點",
            imageName: "anime_16",
            dateTime: "10/14 (三) 00:00",
            episode: "第2集",
            views: "1.1萬",
            isVIPOnly: false
        ),
        AnimeItem(
            title: "當我尋找迷因的來源與出處時 vs 當我要找專題的資料時",
            imageName: "anime_17",
            dateTime: "10/13 (二) 23:30",
            episode: "第2集",
            views: "17.2萬",
            isVIPOnly: false
        ),
        AnimeItem(
            title: "你要不要聽聽看 你現在講什麼",
            imageName: "anime_18",
            dateTime: "10/13 (二) 22:30",
            episode: "第2集",
            views: "2.9萬",
            isVIPOnly: false
        ),
        AnimeItem(
            title: "貴！從來都不是它的缺點 是你的缺點",
            imageName: "anime_19",
            dateTime: "10/13 (二) 22:30",
            episode: "第2集",
            views: "1.2萬",
            isVIPOnly: false
        ),
        AnimeItem(
            title: "錢錢沒有不見",
            imageName: "anime_20",
            dateTime: "10/13 (二) 22:30",
            episode: "第2集",
            views: "1.8萬",
            isVIPOnly: false
        ),
        AnimeItem(
            title: "你們搞得我好亂",
            imageName: "anime_21",
            dateTime: "10/13 (二) 21:30",
            episode: "第2集",
            views: "5.4萬",
            isVIPOnly: false
        ),
        AnimeItem(
            title: "我這條命 是冷氣給的",
            imageName: "anime_22",
            dateTime: "10/13 (二) 20:55",
            episode: "第2集",
            views: "12.4萬",
            isVIPOnly: false
        ),
        AnimeItem(
            title: "快要下班了～～",
            imageName: "anime_23",
            dateTime: "10/13 (二) 01:30",
            episode: "第2集",
            views: "2.3萬",
            isVIPOnly: false
        ),
        AnimeItem(
            title: "當我跟老闆說我想要「加薪」時，老闆的反應",
            imageName: "anime_24",
            dateTime: "10/12 (一) 21:00",
            episode: "第3集",
            views: "13.5萬",
            isVIPOnly: false
        ),
        AnimeItem(
            title: "被主管碎念時的我",
            imageName: "anime_25",
            dateTime: "10/12 (一) 20:30",
            episode: "第2集",
            views: "4.7萬",
            isVIPOnly: true
        ),
        AnimeItem(
            title: "老闆畫的大餅",
            imageName: "anime_26",
            dateTime: "10/12 (一) 12:00",
            episode: "第2集",
            views: "1.3萬",
            isVIPOnly: false
        ),
        AnimeItem(
            title: "工程師的快樂 往往就是這麼樸實無華且枯燥啊！",
            imageName: "anime_27",
            dateTime: "10/12 (一) 00:25",
            episode: "第15集",
            views: "29.1萬",
            isVIPOnly: false
        ),
        AnimeItem(
            title: "準備 debug 的工程師 vs bug",
            imageName: "anime_28",
            dateTime: "10/12 (一) 00:00",
            episode: "第2集",
            views: "1.3萬",
            isVIPOnly: false
        ),
        AnimeItem(
            title: "為什麼一個功能改了又改！？當我許願池膩！",
            imageName: "anime_29",
            dateTime: "10/11 (日) 23:00",
            episode: "第27集",
            views: "17.9萬",
            isVIPOnly: false
        ),
        AnimeItem(
            title: "當你認真讀完考試範圍 上考場時發現你讀錯科目了",
            imageName: "anime_30",
            dateTime: "10/11 (日) 22:30",
            episode: "第2集",
            views: "2.7萬",
            isVIPOnly: true
        )
    ]
}
