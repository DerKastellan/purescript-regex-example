module Tags
  ( Tag,
    extract
  ) where

import Prelude                    (class Show, bind, pure, ($), (<>))
import Data.Array.NonEmpty as NE
import Data.Either                (hush)
import Data.Maybe                 (Maybe(..))
import Data.Tuple                 (Tuple(..), fst, snd)
import Data.String.Regex          (match, regex)
import Data.String.Regex.Flags    (noFlags)

data Tag = Simple String | Annotated String String

instance showTag :: Show Tag where
  show (Simple text)                = "Simple("    <> text <> ")"
  show (Annotated text annotation)  = "Annotated(" <> text <> "," <> annotation <> ")"

extract :: String -> Tag
extract tag =
  case extract_annotated tag of
    Nothing  -> Simple tag
    Just ann -> ann

multi_pattern :: String
multi_pattern = "(.*) \\((.*)\\)"

extract_annotated :: String -> Maybe Tag
extract_annotated tag = do
  multi_regex <- hush (regex multi_pattern noFlags)
  matches     <- match multi_regex tag
  components  <- extract_components (NE.toArray matches)
  text        <- fst components
  annotation  <- snd components
  pure $ Annotated text annotation

extract_components :: Array (Maybe String) -> Maybe (Tuple (Maybe String) (Maybe String))
extract_components [ _, text, annotation] = Just (Tuple text annotation)
extract_components _                      = Nothing
