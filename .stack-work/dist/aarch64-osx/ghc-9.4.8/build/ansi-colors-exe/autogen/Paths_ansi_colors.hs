{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module Paths_ansi_colors (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where


import qualified Control.Exception as Exception
import qualified Data.List as List
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude


#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir `joinFileName` name)

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath



bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath
bindir     = "/Users/ethanvizitei/Code/OSS/arc-utils/.stack-work/install/aarch64-osx/1a732d958ee75d9f7ff2cd9042e4f0ac91c0fd0b5a7717d67b88e556681d5097/9.4.8/bin"
libdir     = "/Users/ethanvizitei/Code/OSS/arc-utils/.stack-work/install/aarch64-osx/1a732d958ee75d9f7ff2cd9042e4f0ac91c0fd0b5a7717d67b88e556681d5097/9.4.8/lib/aarch64-osx-ghc-9.4.8/ansi-colors-0.1.0.0-LdRlhD08FyqGkdGtQuABQk-ansi-colors-exe"
dynlibdir  = "/Users/ethanvizitei/Code/OSS/arc-utils/.stack-work/install/aarch64-osx/1a732d958ee75d9f7ff2cd9042e4f0ac91c0fd0b5a7717d67b88e556681d5097/9.4.8/lib/aarch64-osx-ghc-9.4.8"
datadir    = "/Users/ethanvizitei/Code/OSS/arc-utils/.stack-work/install/aarch64-osx/1a732d958ee75d9f7ff2cd9042e4f0ac91c0fd0b5a7717d67b88e556681d5097/9.4.8/share/aarch64-osx-ghc-9.4.8/ansi-colors-0.1.0.0"
libexecdir = "/Users/ethanvizitei/Code/OSS/arc-utils/.stack-work/install/aarch64-osx/1a732d958ee75d9f7ff2cd9042e4f0ac91c0fd0b5a7717d67b88e556681d5097/9.4.8/libexec/aarch64-osx-ghc-9.4.8/ansi-colors-0.1.0.0"
sysconfdir = "/Users/ethanvizitei/Code/OSS/arc-utils/.stack-work/install/aarch64-osx/1a732d958ee75d9f7ff2cd9042e4f0ac91c0fd0b5a7717d67b88e556681d5097/9.4.8/etc"

getBinDir     = catchIO (getEnv "ansi_colors_bindir")     (\_ -> return bindir)
getLibDir     = catchIO (getEnv "ansi_colors_libdir")     (\_ -> return libdir)
getDynLibDir  = catchIO (getEnv "ansi_colors_dynlibdir")  (\_ -> return dynlibdir)
getDataDir    = catchIO (getEnv "ansi_colors_datadir")    (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "ansi_colors_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "ansi_colors_sysconfdir") (\_ -> return sysconfdir)




joinFileName :: String -> String -> FilePath
joinFileName ""  fname = fname
joinFileName "." fname = fname
joinFileName dir ""    = dir
joinFileName dir fname
  | isPathSeparator (List.last dir) = dir ++ fname
  | otherwise                       = dir ++ pathSeparator : fname

pathSeparator :: Char
pathSeparator = '/'

isPathSeparator :: Char -> Bool
isPathSeparator c = c == '/'
