{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}

import Language.Docker.Creator

main =
    putDockerfileStr $ do
        from "node"
        run "apt-get update"
        [edockerfile|
         RUN apt-get update
         CMD node something.js
        |]
        -- ...
