#!/usr/bin/env ruby

require 'oktakit'

class Okta
  def initialize()
  end

  def createClient(apikey, organization)
    client = Oktakit.new(token: apikey, organization: organization)
    return client
  end

  def getUserList(client)
    response, response_code = client.list_users
    return response
  end

  def isUserApproved(client, user, config)
    approvalStatus = String.new

    response = getUserGroups(client, user[:id])
    status = compareConfigToUserGroups(response, config)

    return status
  end

  private
  def scrubUser()
  end

  def getUserGroups(client, userId)
    response, response_code = client.get_member_groups(userId)
    return response
  end

  def compareConfigToUserGroups(userGroupList, config)
    userGroupList.each do |g|
      if config["GROUPS"].include? g[:profile][:name]
        return "true"
      end
    end
    return "false"
  end
end
