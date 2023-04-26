# TODO List

## 목차
1. [UI](#uiview)
2. [Service](#service)

---

<br>

## UI(View)
### 1. List

```swift

List{
    ForEach(vm.allCoins){ coin in
        CoinRowView(coin: coin, showHoldingsColumn: false)
            .listRowInsets(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 10)) // 리스트 행에 대한 패딩
    }
}

```

### 2. Service
