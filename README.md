# dockerfile-composer

Build Dockerfiles using Haskell with an embedded DSL.

- [Writing Dockerfiles in Haskell](#writing-dockerfiles-in-haskell)
- [Using the QuasiQuoter](#using-the-quasiquoter)
- [Templating Dockerfiles in Haskell](#templating-dockerfiles-in-haskell)
- [Using IO in the DSL](#using-io-in-the-dsl)

## Pretty-printing files

```haskell
import Language.Docker
main = do
    Right d <- parseFile "./Dockerfile"
    putStr (prettyPrint d)
```

## Writing Dockerfiles in Haskell

```haskell
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE OverloadedLists #-}
import Language.Docker

main = putDockerfileStr $ do
    from "node"
    run "apt-get update"
    run ["apt-get", "install", "something"]
    -- ...
```

## Using the QuasiQuoter

```haskell
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
import Language.Docker
main = putDockerfileStr $ do
    from "node"
    run "apt-get update"
    [edockerfile|
    RUN apt-get update
    CMD node something.js
    |]
    -- ...
```

## Templating Dockerfiles in Haskell

```haskell
{-# LANGUAGE FlexibleContexts  #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE OverloadedLists #-}
import Control.Monad
import Language.Docker
import Data.String (fromString)
import qualified Data.Text.Lazy.IO as L

tags = ["7.8", "7.10", "8"]
cabalSandboxBuild packageName = do
    let cabalFile = packageName ++ ".cabal"
    run "cabal sandbox init"
    run "cabal update"
    add [fromString cabalFile] (fromString $ "/app/" ++ cabalFile)
    run "cabal install --only-dep -j"
    add "." "/app/"
    run "cabal build"
main =
    forM_ tags $ \tag -> do
        let df = toDockerfileText $ do
            from ("haskell" `tagged` tag)
            cabalSandboxBuild "mypackage"
        L.writeFile ("./examples/templating-" ++ tag ++ ".dockerfile") df
```

## Using IO in the DSL
By default the DSL runs in the `Identity` monad. By running in IO we can
support more features like file globbing:

```haskell
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE OverloadedLists #-}
import           Language.Docker
import qualified System.Directory     as Directory
import qualified System.FilePath      as FilePath
import qualified System.FilePath.Glob as Glob
import Data.List.NonEmpty (fromList)
import qualified Data.Text.Lazy.IO    as L

main = do
    str <- toDockerfileTextIO $ do
        fs <- liftIO $ do
            cwd <- Directory.getCurrentDirectory
            fs <- Glob.glob "./test/*.hs"
	    let relativeFiles = map (FilePath.makeRelative cwd) fs
            return (fromList relativeFiles)
        from "ubuntu"
	copy $ (toSources fs) `to` "/app/"
    L.putStr str
```
