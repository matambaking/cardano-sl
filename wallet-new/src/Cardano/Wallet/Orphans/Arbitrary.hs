{- | QuickCheck Orphans. |-}

{-# OPTIONS_GHC -fno-warn-orphans #-}
module Cardano.Wallet.Orphans.Arbitrary where

import           Universum

import           Pos.Wallet.Web.ClientTypes.Types
import           Servant
import           Test.QuickCheck (Arbitrary (..))

instance Arbitrary NoContent where
    arbitrary = pure NoContent

instance Arbitrary CWalletInit
instance Arbitrary CWalletMeta
instance Arbitrary CFilePath
instance Arbitrary CAccountMeta
instance Arbitrary CAccountInit
instance Arbitrary CProfile
instance Arbitrary CTxMeta
instance Arbitrary CWalletRedeem
instance Arbitrary CPaperVendWalletRedeem
instance Arbitrary CInitialized
