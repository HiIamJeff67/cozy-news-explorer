 ## 音樂 App
 
 1. 多頁面
    - 第一頁 : 一些新聞(來源?)，包含頭條新聞顯示在最上方並且可以透過 ScrollView 水平捲動，和所有新聞顯示在其下方並只能垂直捲動
    - 第二頁 : 播放軟體(使用 VideoPlayer 播放影片)
 2. 使用 NavigationStack、NavigationLink with value、navigationDestination 切換頁面 & 傳資料到下一頁，navigation bar 上要顯示標題。
 3. 使用 TabView & Tab 製作點選 tab 切換的分頁，分別展示 iPhone & iPad 的 App 畫面。
    1. iPhone App 的 tab bar 在下方。
    2. iPad App 的 tab bar 顯示在上方，而且能顯示側邊欄。
    3. 使用 enum 定義 tab 的清單、文字和 Icon，然後在時既渲染 TabView 時使用。
4. 使用到酷炫動畫
    1. 利用 transition 設定元件出現的動畫效果。
    2. 資料存在 array 裡，array 成員的型別是 struct 定義的自訂型別，遵從 protocol Identifiable。
    3. 使用 List 製作表格，List 搭配遵從 protocol Identifiable 的資料。
    4. 顯示網頁，使用 WebView 或 Link。
5. 支援 dark mode & light mode
    - 錄製 gif 時，請利用 Toggle Appearance 切換 dark mode。
6. 使用 SF Symbol。
7. 使用格子狀排列的 LazyVGrid 將第一頁的各個新聞封面作為圖片製作圖片牆。
8. 設定 App Icon & 名稱。
    - 名稱 : CozyNewsExplorer
    

--- 
9. 使用 Information property list 設定開頭畫面。
10. 客製字型。
11. 簡化大量 modifier 程式的 SwiftUI ViewModifier。
