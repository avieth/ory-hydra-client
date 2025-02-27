{-
   ORY Hydra

   Welcome to the ORY Hydra HTTP API documentation. You will find documentation for all HTTP APIs here.

   OpenAPI Version: 3.0.1
   ORY Hydra API version: latest
   Generated by OpenAPI Generator (https://openapi-generator.tech)
-}

{-|
Module : ORYHydra.API.Public
-}

{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MonoLocalBinds #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE OverloadedStrings #-}
{-# OPTIONS_GHC -fno-warn-name-shadowing -fno-warn-unused-binds -fno-warn-unused-imports #-}

module ORYHydra.API.Public where

import ORYHydra.Core
import ORYHydra.MimeTypes
import ORYHydra.Model as M

import qualified Data.Aeson as A
import qualified Data.ByteString as B
import qualified Data.ByteString.Lazy as BL
import qualified Data.Data as P (Typeable, TypeRep, typeOf, typeRep)
import qualified Data.Foldable as P
import qualified Data.Map as Map
import qualified Data.Maybe as P
import qualified Data.Proxy as P (Proxy(..))
import qualified Data.Set as Set
import qualified Data.String as P
import qualified Data.Text as T
import qualified Data.Text.Encoding as T
import qualified Data.Text.Lazy as TL
import qualified Data.Text.Lazy.Encoding as TL
import qualified Data.Time as TI
import qualified Network.HTTP.Client.MultipartFormData as NH
import qualified Network.HTTP.Media as ME
import qualified Network.HTTP.Types as NH
import qualified Web.FormUrlEncoded as WH
import qualified Web.HttpApiData as WH

import Data.Text (Text)
import GHC.Base ((<|>))

import Prelude ((==),(/=),($), (.),(<$>),(<*>),(>>=),Maybe(..),Bool(..),Char,Double,FilePath,Float,Int,Integer,String,fmap,undefined,mempty,maybe,pure,Monad,Applicative,Functor)
import qualified Prelude as P

-- * Operations


-- ** Public

-- *** disconnectUser

-- | @GET \/oauth2\/sessions\/logout@
-- 
-- OpenID Connect Front-Backchannel Enabled Logout
-- 
-- This endpoint initiates and completes user logout at ORY Hydra and initiates OpenID Connect Front-/Back-channel logout:  https://openid.net/specs/openid-connect-frontchannel-1_0.html https://openid.net/specs/openid-connect-backchannel-1_0.html
-- 
disconnectUser
  :: ORYHydraRequest DisconnectUser MimeNoContent NoContent MimeNoContent
disconnectUser =
  _mkRequest "GET" ["/oauth2/sessions/logout"]

data DisconnectUser  
instance Produces DisconnectUser MimeNoContent


-- *** discoverOpenIDConfiguration

-- | @GET \/.well-known\/openid-configuration@
-- 
-- OpenID Connect Discovery
-- 
-- The well known endpoint an be used to retrieve information for OpenID Connect clients. We encourage you to not roll your own OpenID Connect client but to use an OpenID Connect client library instead. You can learn more on this flow at https://openid.net/specs/openid-connect-discovery-1_0.html .  Popular libraries for OpenID Connect clients include oidc-client-js (JavaScript), go-oidc (Golang), and others. For a full list of clients go here: https://openid.net/developers/certified/
-- 
discoverOpenIDConfiguration
  :: ORYHydraRequest DiscoverOpenIDConfiguration MimeNoContent WellKnown MimeJSON
discoverOpenIDConfiguration =
  _mkRequest "GET" ["/.well-known/openid-configuration"]

data DiscoverOpenIDConfiguration  
-- | @application/json@
instance Produces DiscoverOpenIDConfiguration MimeJSON


-- *** isInstanceReady

-- | @GET \/health\/ready@
-- 
-- Check Readiness Status
-- 
-- This endpoint returns a 200 status code when the HTTP server is up running and the environment dependencies (e.g. the database) are responsive as well.  If the service supports TLS Edge Termination, this endpoint does not require the `X-Forwarded-Proto` header to be set.  Be aware that if you are running multiple nodes of this service, the health status will never refer to the cluster state, only to a single instance.
-- 
isInstanceReady
  :: ORYHydraRequest IsInstanceReady MimeNoContent HealthStatus MimeJSON
isInstanceReady =
  _mkRequest "GET" ["/health/ready"]

data IsInstanceReady  
-- | @application/json@
instance Produces IsInstanceReady MimeJSON


-- *** oauth2Token

-- | @POST \/oauth2\/token@
-- 
-- The OAuth 2.0 Token Endpoint
-- 
-- The client makes a request to the token endpoint by sending the following parameters using the \"application/x-www-form-urlencoded\" HTTP request entity-body.  > Do not implement a client for this endpoint yourself. Use a library. There are many libraries > available for any programming language. You can find a list of libraries here: https://oauth.net/code/ > > Do note that Hydra SDK does not implement this endpoint properly. Use one of the libraries listed above!
-- 
-- AuthMethod: 'AuthBasicBasic', 'AuthOAuthOauth2'
-- 
oauth2Token
  :: (Consumes Oauth2Token MimeFormUrlEncoded)
  => GrantType -- ^ "grantType"
  -> ORYHydraRequest Oauth2Token MimeFormUrlEncoded Oauth2TokenResponse MimeJSON
oauth2Token (GrantType grantType) =
  _mkRequest "POST" ["/oauth2/token"]
    `_hasAuthType` (P.Proxy :: P.Proxy AuthBasicBasic)
    `_hasAuthType` (P.Proxy :: P.Proxy AuthOAuthOauth2)
    `addForm` toForm ("grant_type", grantType)

data Oauth2Token  
instance HasOptionalParam Oauth2Token Code where
  applyOptionalParam req (Code xs) =
    req `addForm` toForm ("code", xs)
instance HasOptionalParam Oauth2Token RefreshToken where
  applyOptionalParam req (RefreshToken xs) =
    req `addForm` toForm ("refresh_token", xs)
instance HasOptionalParam Oauth2Token RedirectUri where
  applyOptionalParam req (RedirectUri xs) =
    req `addForm` toForm ("redirect_uri", xs)
instance HasOptionalParam Oauth2Token ClientId where
  applyOptionalParam req (ClientId xs) =
    req `addForm` toForm ("client_id", xs)

-- | @application/x-www-form-urlencoded@
instance Consumes Oauth2Token MimeFormUrlEncoded

-- | @application/json@
instance Produces Oauth2Token MimeJSON


-- *** oauthAuth

-- | @GET \/oauth2\/auth@
-- 
-- The OAuth 2.0 Authorize Endpoint
-- 
-- This endpoint is not documented here because you should never use your own implementation to perform OAuth2 flows. OAuth2 is a very popular protocol and a library for your programming language will exists.  To learn more about this flow please refer to the specification: https://tools.ietf.org/html/rfc6749
-- 
oauthAuth
  :: ORYHydraRequest OauthAuth MimeNoContent NoContent MimeNoContent
oauthAuth =
  _mkRequest "GET" ["/oauth2/auth"]

data OauthAuth  
instance Produces OauthAuth MimeNoContent


-- *** revokeOAuth2Token

-- | @POST \/oauth2\/revoke@
-- 
-- Revoke OAuth2 Tokens
-- 
-- Revoking a token (both access and refresh) means that the tokens will be invalid. A revoked access token can no longer be used to make access requests, and a revoked refresh token can no longer be used to refresh an access token. Revoking a refresh token also invalidates the access token that was created with it. A token may only be revoked by the client the token was generated for.
-- 
-- AuthMethod: 'AuthBasicBasic', 'AuthOAuthOauth2'
-- 
revokeOAuth2Token
  :: (Consumes RevokeOAuth2Token MimeFormUrlEncoded)
  => Token -- ^ "token"
  -> ORYHydraRequest RevokeOAuth2Token MimeFormUrlEncoded NoContent MimeNoContent
revokeOAuth2Token (Token token) =
  _mkRequest "POST" ["/oauth2/revoke"]
    `_hasAuthType` (P.Proxy :: P.Proxy AuthBasicBasic)
    `_hasAuthType` (P.Proxy :: P.Proxy AuthOAuthOauth2)
    `addForm` toForm ("token", token)

data RevokeOAuth2Token  

-- | @application/x-www-form-urlencoded@
instance Consumes RevokeOAuth2Token MimeFormUrlEncoded

instance Produces RevokeOAuth2Token MimeNoContent


-- *** userinfo

-- | @GET \/userinfo@
-- 
-- OpenID Connect Userinfo
-- 
-- This endpoint returns the payload of the ID Token, including the idTokenExtra values, of the provided OAuth 2.0 Access Token.  For more information please [refer to the spec](http://openid.net/specs/openid-connect-core-1_0.html#UserInfo).  In the case of authentication error, a WWW-Authenticate header might be set in the response with more information about the error. See [the spec](https://datatracker.ietf.org/doc/html/rfc6750#section-3) for more details about header format.
-- 
-- AuthMethod: 'AuthOAuthOauth2'
-- 
userinfo
  :: ORYHydraRequest Userinfo MimeNoContent UserinfoResponse MimeJSON
userinfo =
  _mkRequest "GET" ["/userinfo"]
    `_hasAuthType` (P.Proxy :: P.Proxy AuthOAuthOauth2)

data Userinfo  
-- | @application/json@
instance Produces Userinfo MimeJSON


-- *** wellKnown0

-- | @GET \/.well-known\/jwks.json@
-- 
-- JSON Web Keys Discovery
-- 
-- This endpoint returns JSON Web Keys to be used as public keys for verifying OpenID Connect ID Tokens and, if enabled, OAuth 2.0 JWT Access Tokens. This endpoint can be used with client libraries like [node-jwks-rsa](https://github.com/auth0/node-jwks-rsa) among others.
-- 
wellKnown0
  :: ORYHydraRequest WellKnown0 MimeNoContent JSONWebKeySet MimeJSON
wellKnown0 =
  _mkRequest "GET" ["/.well-known/jwks.json"]

data WellKnown0  
-- | @application/json@
instance Produces WellKnown0 MimeJSON

