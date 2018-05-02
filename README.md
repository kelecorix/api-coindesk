# CoinDesk API 

Haskell bindings for CoinDesk API / (BPI, Bitcoin Price Index) [http://www.coindesk.com/api/]

`src` - contains actual API that can be used in 3rd part apps
`app` - executable for CLI app that can be used to view current value or run continuosly

Just build repository with `stack build` and use following

```
$ stack exec -- cdsk 
```

or simply `cdsk` if you used `stack install` command

```
$ cdsk 
```
that will bring following output

```
Apr 14, 2016 15:25:00 UTC | 377.0385 EUR
```

For continuous mode use `-d` switch, runs every 30 seconds
```
$ cdsk -d
```
```
Apr 14, 2016 15:29:00 UTC | 376.8956 EUR
Apr 14, 2016 15:30:00 UTC | 376.8610 EUR
Apr 14, 2016 15:31:00 UTC | 376.8805 EUR
...
```
