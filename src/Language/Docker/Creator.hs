module Language.Docker.Creator
  (
    -- * Writting Dockerfiles (@Language.Docker.EDSL@)
    Language.Docker.EDSL.toDockerfileText,
    Language.Docker.EDSL.toDockerfile,
    Language.Docker.EDSL.putDockerfileStr,
    Language.Docker.EDSL.writeDockerFile,
    Language.Docker.EDSL.toDockerfileTextIO,
    Language.Docker.EDSL.toDockerfileIO,
    Language.Docker.EDSL.runDockerfileIO,
    Language.Docker.EDSL.runDockerfileTextIO,
    Control.Monad.IO.Class.liftIO,
    Language.Docker.EDSL.from,

    -- ** Constructing base images
    Language.Docker.EDSL.tagged,
    Language.Docker.EDSL.untagged,
    Language.Docker.EDSL.digested,
    Language.Docker.EDSL.aliased,

    -- ** Syntax
    Language.Docker.EDSL.add,
    Language.Docker.EDSL.user,
    Language.Docker.EDSL.label,
    Language.Docker.EDSL.stopSignal,
    Language.Docker.EDSL.copy,
    Language.Docker.EDSL.copyFromStage,
    Language.Docker.EDSL.to,
    Language.Docker.EDSL.fromStage,
    Language.Docker.EDSL.ownedBy,
    Language.Docker.EDSL.toSources,
    Language.Docker.EDSL.toTarget,
    Language.Docker.EDSL.run,
    Language.Docker.EDSL.runArgs,
    Language.Docker.EDSL.cmd,
    Language.Docker.EDSL.cmdArgs,
    Language.Docker.EDSL.healthcheck,
    Language.Docker.EDSL.check,
    Language.Docker.EDSL.interval,
    Language.Docker.EDSL.timeout,
    Language.Docker.EDSL.startPeriod,
    Language.Docker.EDSL.retries,
    Language.Docker.EDSL.workdir,
    Language.Docker.EDSL.expose,
    Language.Docker.EDSL.ports,
    Language.Docker.EDSL.tcpPort,
    Language.Docker.EDSL.udpPort,
    Language.Docker.EDSL.variablePort,
    Language.Docker.EDSL.portRange,
    Language.Docker.EDSL.udpPortRange,
    Language.Docker.EDSL.volume,
    Language.Docker.EDSL.entrypoint,
    Language.Docker.EDSL.entrypointArgs,
    Language.Docker.EDSL.maintainer,
    Language.Docker.EDSL.env,
    Language.Docker.EDSL.arg,
    Language.Docker.EDSL.comment,
    Language.Docker.EDSL.onBuild,
    Language.Docker.EDSL.onBuildRaw,
    Language.Docker.EDSL.embed,
    Language.Docker.EDSL.Quasi.edockerfile,

    -- ** Support types for the EDSL
    Language.Docker.EDSL.EDockerfileM,
    Language.Docker.EDSL.EDockerfileTM,
    Language.Docker.EDSL.Types.EBaseImage (..),

    -- * QuasiQuoter (@Language.Docker.EDSL.Quasi@)
    Language.Docker.EDSL.Quasi.dockerfile,

    -- * Instruction and InstructionPos helpers
    Language.Docker.EDSL.instructionPos,
) where

import qualified Control.Monad.IO.Class
import qualified Language.Docker.EDSL
import qualified Language.Docker.EDSL.Quasi
import qualified Language.Docker.EDSL.Types
