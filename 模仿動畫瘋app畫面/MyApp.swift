import SwiftUI

/// 應用程式的主進入點（App Entry Point）
/// 負責啟動 App 並載入巴哈姆特動畫瘋首頁的主畫面 `ContentView`
@main struct MyApp: App {
    /// 定義應用程式的場景（Scene）與根視圖（Root View）
    var body: some Scene {
        WindowGroup {
            // 載入主畫面視圖
            ContentView()
        }
    }
}
