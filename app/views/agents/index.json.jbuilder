json.array!(@agents) do |agent|
  json.extract! agent, :id, :name, :codeagent
  json.url agent_url(agent, format: :json)
end
