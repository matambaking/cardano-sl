{-# LANGUAGE DataKinds             #-}
{-# LANGUAGE FlexibleContexts      #-}
{-# LANGUAGE FlexibleInstances     #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE ScopedTypeVariables   #-}
{-# LANGUAGE TypeApplications      #-}
{-# LANGUAGE TypeFamilies          #-}
{-# LANGUAGE TypeOperators         #-}
{-# LANGUAGE UndecidableInstances  #-}
{-# OPTIONS_GHC -fno-warn-orphans  #-}
module Cardano.Wallet.API.V1.Parameters where

import           Universum

import           Cardano.Wallet.API.Types    (AlternativeApiArg, DQueryParam,
                                              WithDefaultApiArg, mapRouter)
import           Cardano.Wallet.API.V1.Types

import           Servant

-- | A special parameter which combines `response_format` query argument and
-- `Daedalus-Response-Format` header (which have the same meaning) in one API argument.
type ResponseFormatParam = WithDefaultApiArg
    (AlternativeApiArg (QueryParam "response_format") (Header "Daedalus-Response-Format"))
    ResponseFormat

-- | Unpacked pagination parameters.
type WithWalletRequestParams c =
       DQueryParam "page"     Page
    :> DQueryParam "per_page" PerPage
    :> ResponseFormatParam
    :> c

-- | Stub datatype which is used as special API argument specifier for
-- grouped pagination parameters.
data WalletRequestParams

instance HasServer (WithWalletRequestParams subApi) ctx =>
         HasServer (WalletRequestParams :> subApi) ctx where
    type ServerT (WalletRequestParams :> subApi) m =
        PaginationParams -> ServerT subApi m
    route =
        mapRouter @(WithWalletRequestParams subApi) route $
        \f ppPage ppPerPage ppResponseFormat -> f $ PaginationParams {..}
