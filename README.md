# Q : Deeply-nested optional-property record value access combinators for the real world.

(Also some other combinators, because I wanted to put them in here, because they're kind of related.)

In our little PL community, the [official statement](https://github.com/elm/package.elm-lang.org/blob/fbaea7dbed03073a63b8c4c5212543acf95bb2e4/src/frontend/Page/Search.elm#L409-L429) on lenses is that they are considered-harmful; and even though they have in fact been conjured from the void in Elm, they can be uncomfortable to use - and in many cases, it is often easier and much nicer to flatten data structures before operating on them.

But what if you don't _want_ to _operate_ on them, per se? What if you have some gigantic, deeply-nested record structure with a bunch of optional properties - or worse-yet, what if the _code that you are writing_ exists at the intersection of deeply-nested values?

Consider the following scenario: You have a JSON object, and it looks like _this_:

```json
{
  "user": {
    "settings": {
      "notifications": {
        "activity": {
          "likes": true,
          "follows": true,
          "retweets": {
            "fromFollowers": true,
            "fromFollowing": true,
            "fromEveryone": {
              "includingMuted": true
            }
          }
        }  
      }
    },
    "profile": {
      "handle": "@lambdapriest",
      "homepage": "x.com/lambdapriest"
    }
  }
}
```

You decode it into a type that matches its structure exactly, because at some point, you're going to need access to enough of the parts of its full representation that it's just a billion times easier to do so. Or maybe you're using some tooling that does type generation for you, and this is what you get for free. For whatever reason, this is what you have. And for that same reason - maybe it's the codegen, maybe it's the API def, whatever - _every field is nullable and/or optional_, and so _have fun with that_.

This is **not** why I created `jmpavlick/q`; it's what the cool kids call a "post-hoc rationalization". What you see here, is a problem that is desperately hunting for a solution, that was found by a man that was desperately hunting for a problem to solve.

## What can it do?

Check it out:

```elm

import A

type alias User =
    { ... pretend that I wrote the type for this, ok? }


notifyOnRetweetsIncludingMuted : User -> Bool
notifyOnRetweetsIncludingMuted =
    Maybe.withDefault False <<
        A.qqqqqqq
            .user
            .settings
            .notifications
            .activity
            .retweets
            .fromEveryone
            .includingMuted
```

Each `q` in a function's name represents a call to a function whose signature is `a -> Maybe b`, for some `a` and some `b`.

From the `A` module, the actual value to be applied to the composition is just a value `q`; from the `Q` module, it's a `Maybe q`.

The letters in the function names give you an indicator of how many "maybe" values are involved in the function's params - for instance:

```elm
module Q exposing (..)

qq : (a -> Maybe b) -> (b -> Maybe c) -> Maybe a -> Maybe c
```

The call site for this looks like

``` elm
nx = Q.qq ...
```

- An uppercase `Q` to represent that the value being operated on is a `Maybe`
- Two lowercase `q`s to represent two optional maps

Similarly, with `A`:

```
module A exposing (..)

qq : (a -> Maybe b) -> (b -> Maybe c) -> a -> Maybe c
```

The call site looks like:

```elm
nx = A.qq
```

- An uppercase `A` to represent that the value being operated on is an "actual value" - i.e, not a `Maybe`
- Two lowercase `q`s to represent the optional maps

It's basically just syntactic sugar around `Maybe.andThen`; and unlike other cursed things that I hold near and dear to my heart, [@jfmengels](https://github.com/jfmengels/) doesn't have an `elm-review` rule against it _yet_.

## What's the catch?

- It only goes up to `qqqqqqqqqqq`, so if you need to map through more than 11 levels, you're out of luck, sorry
- It's not a lens; it is, however, a glimpse into the void
- Nobody actually needs this; at least, I hope they don't