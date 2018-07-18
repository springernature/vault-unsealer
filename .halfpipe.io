team: engineering-enablement
pipeline: vault-unsealer
slack_channel: "#ee-re"

tasks:
- type: docker-push
  image: eu.gcr.io/halfpipe-io/vault-unsealer
