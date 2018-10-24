# PureScript Regex Example

This is a little demo I wrote since I could not find a good example of working with `Data.String.Regex` that covers working with matches while trying to learn PureScript.

It's about using these two functions really:
* `regex :: String -> RegexFlags -> Either String Regex`
* `match :: Regex -> String -> Maybe (NonEmptyArray (Maybe String))`

It uses the `Maybe` monad and `do` notation to handle errors while maintaining a degree of clean code.

The example tries to tell apart two possible formats for "tags":
* A simple tag which is essentially just a string label: `Friend`, `Approved`
* An annotated tag which contains more specific information in brackets: `Mammal (Dog)`, `Published (Github)`

The challenge was the result type of `match` with its multiple levels of optionality. When matching out an annotated tag we're interested in the two match groups containing the components of the annotated tag. So, only a match array of length 3 is interesting - complete match (to be ignored), match group 1, match group 2.

(Also, I wanted to avoid the use of `unsafePartial`.)

The beauty of using the `Maybe` monad with `do` notation is that we can rely on the "magic" that everything to the left of `<-` is unwrapped from a `Maybe` and we can treat it like any other value while the whole computation will result in `Nothing` if any step didn't work as expected. The lack of `if` and `case` statements is a boon other languages do not grant us without demanding the heavy price of exceptions.

## Build and run

* `bower install`
* `pulp build`
* `pulp run`

## Many thanks to the authors of...

* http://adit.io/posts/2013-04-17-functors,_applicatives,_and_monads_in_pictures.html
* http://yannesposito.com/Scratch/en/blog/Haskell-the-Hard-Way/
* http://learnyouahaskell.com/chapters
* PureScript and its libraries
