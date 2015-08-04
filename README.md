# Lion and Lamb
This is the source code for the free **Lion and Lamb - Admiring Jesus Christ** iOS 8 app. It can be compiled with Xcode 6.4+ and it uses ARC.

This app creates word clouds using the most frequent words from a chosen book of the Bible.  The larger the word appears in the cloud, the more often it occurs in the Bible.

* [Download the free Lion and Lamb app](https://itunes.apple.com/app/lion-lamb-admiring-jesus-christ/id1018992236?mt=8&at=1010l3f4) from the App Store.

#### Life's Greatest Decision
For more information about forgiveness of sin, peace with God, and the gift of everlasting life, consider [Following Christ: Life's Greatest Decision](http://followchrist.ag.org/decision.cfm).

God bless you!

## App features

* Create word clouds of books of the Bible
* Select from a variety of fonts and colors
* Save favorite word clouds as wallpaper
* Share favorite word clouds with friends
* View statistics for most frequent words

You can tap the word cloud to shuffle its words, or swipe left or right to switch to an adjacent Bible book.  Tapping the Bible book name lets you change the word cloud preferences, and show statistics.

## License
This source code is distributed under [the MIT license](LICENSE.txt).

## Credit

The app is inspired by the beautiful word clouds at [Sixty-Six Clouds](http://www.66clouds.com/).

### App icon
App icon artwork by José Beraka Lobos.

### Implementation
The cloud layout operation generally follows the [method that Johnathan Feinberg, the creator of Wordle, explained](http://stackoverflow.com/a/1478314/4151918).

#### To do
* Break glyph down into many smaller bounding rects to enable word placement within a glyph's bounding box.
* Try placing words along an ever-increasing spiral, instead of along concentric circles.

## Designed for iOS 8
* Uses Universal storyboard
* Supports iPhone 6 and iPhone 6 Plus
* Cloud layout handled by an NSOperation.