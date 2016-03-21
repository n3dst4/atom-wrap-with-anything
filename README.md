# wrap-with-anything

Wrap text selections instead of replacing them when certain characters are
typed.

![Screenshot of inserting punctuation around words ](https://cloud.githubusercontent.com/assets/280206/11319777/c36c9548-907a-11e5-8ee5-11c9f261dc23.gif)

The Atom builtin package `bracket-matcher` provides a feature where if you have
text selected and type any kind of opening bracket or quote, the selection is
wrapped instead of being replaced.

This package (wrap-with-anything) extends this feature to allow an arbitrary
list of characters which will trigger this wrapping behaviour. The default list
is `*`, `~`, `/`, `_`, and space.

| Char  |  Reason |
|------|---------------------------------------------|
| `*`  |  Mardown *emphasis* (single) and **strong emphasis** (double) |
| `_`  |  Mardown _emphasis_ (single) and __strong emphasis__ (double) |
| `~`  |  Mardown ~~strikethrough~~ (when double) |
| `/`  |  Used for italics in various markups. Also delimits regular expressions in many languages |
| (space)  |  Useful for padding things out |

You can customise this list in the settings.
