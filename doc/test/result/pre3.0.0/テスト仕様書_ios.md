# テスト仕様書

## 1. 前提

- **アプリのバージョン**: 3.0.0（未リリース）
- **実施日**: 2024-06-02
- **OS**: iOS 17.0.3
- **デバイス**: iPhone15
- **対象シーズン**: end2023

## 2. テスト項目

### 2.1 TOP 画面

- [x] 「クイズの条件を設定」タップで、クイズ条件設定画面へ遷移する
- [x] 「クイズをプレイ」タップで、ノーマルクイズプレイ画面へ遷移する
- [x] （今日の1問未プレイ）「今日の1問」タップで、「今日の1問をプレイするかの確認ダイアログ」が出る
  - [x] ダイアログの「いいえ」タップで、ダイアログが閉じる
  - [x] ダイアログの「はい」タップで、デイリークイズプレイ画面へ遷移する
- [x] （今日の1問プレイ済み）「今日の1問」タップで、プレイ済みのダイアログが出る
- [x] 「プレイ履歴」タップで、ギャラリー画面へ遷移する
- [x] 「その他」タップで、ダイアログが出る
  - [x] ダイアログの「お問い合わせ」タップで、メールアプリが起動し、宛先や本文が入力されている
  - [x] ダイアログの「利用規約」タップで、利用規約の Webページが WetTo で表示される
  - [x] ダイアログの「プライバシーポリシー」タップで、プライバシーポリシーの Webページが WetTo で表示される
  - [x] ダイアログの「プッシュ通知」タップで、プッシュ通知設定用のダイアログが出る
    - [x] ダイアログでトグルスイッチが正常に動く

### 2.1. クイズ条件設定 画面

- [x] 球団の選択・選択解除ができる
  - [x] 1つのみ選択中の状態だと、選択解除できない（モーダル）
- [x] 最低通算試合数を変更できる
- [x] 最低通算ヒット数を設定できる
- [x] 最低通算ホームラン数を設定できる
- [x] 出題する成績を設定できる
  - [x] 4つ選択しないとモーダルを閉じられない
- [x] 「TOPへ戻る」タップで、TOP画面に戻る
- [x] 「クイズをプレイ」タップで、クイズプレイ画面へ遷移する
- [x] 対象者がいない条件を設定し「クイズをプレイ」タップで、対象者がいない旨のダイアログが出る
  - 対象者がいない条件：日本ハム、最低通算ホームラン数 200

### 2.2. ノーマルクイズプレイ 画面

- [x] 設定されている条件を満たすクイズが出題される
- [x] すべての成績が閉じられた状態でクイズが始まる
- [x] 「次の成績を表示」タップで、成績が1つ公開される
- [x] 「全ての成績を表示」タップで、確認ダイアログが出る
  - [x] ダイアログの「はい」タップで成績が全て公開される
- [x] 「諦める」タップで、確認ダイアログが出る
  - [x] ダイアログの「はい」タップで、クイズ結果画面に遷移する
    - [x] 不正解である
    - [x] 成績の表示状態が、プレイ画面のものを引き継がれている
- [x] 正解の選手を入力し、「回答する」タップ
  - [x] クイズ結果画面に遷移する
    - [x] 正解である
    - [ ] ~~花吹雪が舞う~~ NG
    - [x] 成績の表示状態が、プレイ画面のものを引き継がれている
  - [x] ギャラリー画面に結果が保存される
- [x] 不正解の選手を入力し、「回答する」タップ
  - [ ] ~~広告が表示される（確率で表示される。何回か試して広告が出ればOK）~~ NG
  - [x] 不正解のダイアログが出る
    - [x] ダイアログで「諦める」タップ
      - [ ] ~~クイズ結果画面に遷移する（不正解）~~ NG
    - [x] ダイアログで「もう一度〜」タップ
      - [x] ダイアログが閉じる（クイズプレイ画面のまま）

### 2.3 ノーマルクイズ結果 画面

- [x] 「同じ条件でもう一度」タップで、再度ノーマルクイズプレイ画面へ遷移する
- [x] 「クイズをシェア」タップで、クイズシェア用のモーダルが出る
  - [x] クイズの画像とテキストが正常
- [x] 「TOPへ戻る」タップで、TOP画面に戻る

### 2.4 デイリークイズプレイ（当日） 画面
※ 諦めるケース、3回不正解のケースは 2.9 でテストするため、ここでは正解のケースをテストする
※ 不正解 → 諦める、諦めるケースはテストしない

- [x] すべての成績が閉じられ、ライフが3の状態でクイズが始まる
- [x] 「次の成績を表示」タップで、成績が1つ公開される
- [x] 「全ての成績を表示」タップで、確認ダイアログが出る
  - [x] ダイアログの「はい」タップで成績が全て公開される
- [x] 正解の選手を入力し、「回答する」タップ
  - [x] クイズ結果画面に遷移する
    - [x] 正解である
    - [ ] ~~花吹雪が舞う~~ NG
    - [x] 成績の表示状態が、プレイ画面のものを引き継がれている
  - [x] ギャラリー画面に結果が保存される

### 2.5 デイリークイズ結果（当日） 画面

- [x] 「クイズをシェア」タップで、クイズシェア用のモーダルが出る
  - [x] クイズの画像とテキストが正常
- [x] 「TOPへ戻る」タップで、TOP画面に戻る

### 2.6 ギャラリー 画面

- [x] スワイプでタブを切り替えられる（「ノーマルクイズ」タブと「今日の1問」タブ）
- [x] ノーマルクイズの結果が一覧で表示される
- [x] 「ノーマルクイズの結果」カードをタップで、プレイ履歴（ノーマルクイズ）画面へ遷移する
- [x] デイリークイズの結果がカレンダー形式で表示される
- [x] 「デイリークイズ」タブのカレンダーで、スワイプや「>」「<」タップで対象月を切り替えられる
- [x] 「デイリークイズの結果」セル（プレイ済み）をタップで、プレイ履歴（デイリークイズ）画面へ遷移する
- [x] 「デイリークイズの結果」セル（未プレイ）をタップで、「該当日のデイリークイズをプレイするかの確認ダイアログ」が出る
  - [x] ダイアログの「いいえ」タップで、ダイアログが閉じる
  - [x] ダイアログの「はい」タップで、リワード広告が表示される
    - [x] リワード広告の「閉じる」タップで、デイリークイズプレイ（過去）画面へ遷移する
- [x]  「TOPへ戻る」タップで、TOP画面に戻る

### 2.7 プレイ履歴（ノーマルクイズ） 画面

- [x] 「正解を確認」タップで、正解のダイアログが出る
- [x] 「クイズをシェア」タップで、クイズシェア用のモーダルが出る
  - [x] クイズの画像とテキストが正常
- [x] 「この履歴を消す」タップで、確認ダイアログが出る
  - [x] ダイアログの「いいえ」タップで、ダイアログが閉じる
  - [x] ダイアログの「はい」タップで、プレイ履歴が削除され、ギャラリー画面に戻る
- [x] 「戻る」タップで、ギャラリー画面に戻る

### 2.8 プレイ履歴（デイリークイズ） 画面

- [x] 「正解を確認」タップで、正解のダイアログが出る
- [x] 「クイズをシェア」タップで、クイズシェア用のモーダルが出る
  - [x] クイズの画像とテキストが正常
- [x] 「戻る」タップで、TOP画面に戻る

### 2.9 デイリークイズプレイ（過去） 画面
※ 正解のケースは 2.4 でテストするため、3回不正解のケースをテストする
※ 不正解 → 諦める、諦めるケースはテストしない

- [x] すべての成績が閉じられ、ライフが3の状態でクイズが始まる
- [x] 「次の成績を表示」タップで、成績が1つ公開される
- [x] 「全ての成績を表示」タップで、確認ダイアログが出る
  - [x] ダイアログの「はい」タップで成績が全て公開される
- [x] 不正解の選手を入力し、「回答する」タップ
  - [x] 不正解のダイアログが出る
    - [x] ダイアログで「もう一度〜」タップ
      - [x] ダイアログが閉じる（クイズプレイ画面のまま）
      - [x] ライフが1減る
- [ ] ~~2回不正解した状態で不正解の選手を入力し、「回答する」タップ~~ NG
  - [ ] 最終回等の確認ダイアログが出る
    - [ ] ダイアログの「いいえ」タップで、ダイアログが閉じる
    - [ ] ダイアログの「はい」タップで、クイズ結果画面に遷移する
      - [ ] 不正解である
      - [ ] 成績の表示状態が、プレイ画面のものを引き継がれている
- [x] ギャラリー画面に結果が保存される

### 2.10 デイリークイズ結果（過去） 画面

- [x] 「クイズをシェア」タップで、クイズシェア用のモーダルが出る
  - [x] クイズの画像とテキストが正常
- [x] 「TOPへ戻る」タップで、TOP画面に戻る

## 3. コメント

### 3.1 NG だったテスト項目

- 2.2
  - 不正解でも広告が表示されない
- 2.2, 2.4
  - 花吹雪の表示がおかしい
- 2.2
  - 不正解ダイアログの「諦める」をタップしても何も起こらない
- 2.9
  - ライフが残り2の状態で不正解すると、不正解扱いで結果画面に遷移する

### 3.2 備考

## 4. 未作成のテスト項目

- ノーマルクイズ結果画面でのレビュー促すダイアログ関連
- PUSH通知関連
- 強制アップデート関連
