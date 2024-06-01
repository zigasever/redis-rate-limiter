--sliding window rate limter

local userKey = KEYS[1]
local tokenLimit = tonumber(ARGV[1])

local windowSizeMs = tonumber(ARGV[2])
local epochMs      = tonumber(ARGV[3])
--remove tokens outside window
redis.call('ZREMRANGEBYSCORE', userKey, -inf (epochMs - windowSizeMs))
local currentTokens = redis.call('ZCARD', userKey)

if currentTokens < tokenLimit then
    redis.call('ZADD', userKey, epochMs, epochMs)
    redis.call('EXPIRE', userKey, windowSizeMs)
    return 1
else
    return 0
end
