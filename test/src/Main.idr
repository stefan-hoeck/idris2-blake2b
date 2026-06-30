module Main

import Hedgehog
import Data.Buffer
import Data.ByteString
import Data.Hash.BLAKE2b

%default total

prop_empty384 : Property
prop_empty384 =
  property1 $
    encodeLE (blake2b 6 "") ===
      "b32811423377f52d7862286ee1a72ee540524380fda1724a6f25d7978c6fd3244a6caf0498812673c5e05ef583825100"

prop_empty512 : Property
prop_empty512 =
  property1 $
    encodeLE (blake2b 8 "") ===
      "786a02f742015903c6c6fd852552d272912f4740e15847618a86e217f71f5419d25e1031afee585313896444934eb04b903a685b1448b755d56f701afe9be2ce"

prop_fox : Property
prop_fox =
  property1 $
    encodeLE (blake2b 8 "The quick brown fox jumps over the lazy dog") ===
      "a8add4bdddfd93e4877d2746e62817b116364a1fa7bc148d95090bc7333b3673f82401cf7aa2e4cb1ecd90296e3f14cb5413f8ed77be73045b13914cdcd6a918"

prop_fox2 : Property
prop_fox2 =
  property1 $
    encodeLE (blake2b 8 "The quick brown fox jumps over the lazy dof") ===
      "ab6b007747d8068c02e25a6008db8a77c218d94f3b40d2291a7dc8a62090a744c082ea27af01521a102e42f480a31e9844053f456b4b41e8aa78bbe5c12957bb"

main : IO ()
main =
  test
    [ MkGroup "Data.Hash.BLAKE2b"
        [ ("prop_empty384", prop_empty384)
        , ("prop_empty512", prop_empty512)
        , ("prop_fox", prop_fox)
        , ("prop_fox2", prop_fox2)
        ]
    ]
