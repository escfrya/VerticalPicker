# VerticalPicker

## Usage

#### Simple slider with background color:
```swift
let slider = VerticalPicker(frame: CGRect(x: 100, y: 200, width: 65, height: 135))
slider.backgroundColor = UIColor.red
slider.valueChanged = { value, isFinal in
    print(value)
}
view.addSubview(slider)
```

#### With background image:
```swift
slider.backgroundImage = UIImage(named: "color-picker")
```

#### With gradient background:
```swift
slider.gradientTopColor = UIColor.white
slider.gradientBottomColor = UIColor.black
```

<img src="https://raw.githubusercontent.com/escfrya/VerticalPicker/master/Images/Example.png" alt="Example screenshot" align="left" />
