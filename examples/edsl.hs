{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE OverloadedLists #-}

import Language.Docker.Composer

main =
    putDockerfileStr $ do
        from "node"
        run "apt-get update"
        cmd ["node", "app.js"]
        -- ...
