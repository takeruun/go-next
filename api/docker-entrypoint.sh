#!/bin/bash

set -e

amazon-ssm-agent -register -code "${SSM_AGENT_CODE}" -id "${SSM_AGENT_ID}" -region "ap-northeast-1"
amazon-ssm-agent

exec "$@"