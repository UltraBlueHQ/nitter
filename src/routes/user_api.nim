# SPDX-License-Identifier: AGPL-3.0-only
import asyncdispatch, jester, json, options
import "../api"
import "../types"
import "../utils"

proc createUserApiRouter*() =
  router userApi:
    get "/api/@username":
      let username = @"username"
      let user = await getGraphUser(username)
      
      if user.username.len == 0:
        resp Http404, "User not found"
      elif user.suspended:
        resp Http403, "User suspended"
      else:
        resp Http200, $user.toJson, {"Content-Type": "application/json"}
