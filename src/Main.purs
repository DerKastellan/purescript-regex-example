module Main where

import Prelude
import Effect           (Effect)
import Effect.Console   (log)
import Tags             (extract)

main :: Effect Unit
main = do
  let simple = "Dog"
  log $ show $ extract simple
  let annotated = "Published (Github)"
  log $ show $ extract annotated
