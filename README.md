# Streamly strings

You need ghc-9.6.5. To run the benchmarks for decoding to Unicode and printing the last symbol, do:

```sh
cabal build
exe=$(cabal -v0 list-bin streamly-string)
time "${exe}" <large-text-file> "string"
time "${exe}" <large-text-file> "text"
time "${exe}" <large-text-file> "streamly"
```

My results are:

- string: 1,152s
- text: 0,654s
- steramly: 0,222s

