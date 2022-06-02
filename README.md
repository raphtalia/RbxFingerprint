# RbxFingerprint

This repository serves to explain and demonstrate a privacy vulnerability in
Roblox that allows developers to track users across different accounts.

**It is unclear of Roblox will take action against developers who implement this
so experiment at your own risk.**

## Inspiration

Sometime last year (2021) I sought out to make an anti-exploit that would solve
the issue of exploiters just hopping on another account or alt and continuing
their exploiting. While in the shower I realized `os.clock()` provides a very
good way to achieve this. The function returns the number of seconds since the
CPU first started. On Windows machines this count would persist even after the
user shutdown their computer and only reset when the computer was restarted. The
odds of 2 players on a game having started their computer at the same exact time
in my opinion, very low. Just to ensure that no 2 players were accidentally
identified as the same computer more data points can be used such as if the
device has a touchscreen and other information provided by Roblox.

Shoutout to the [guy](https://twitter.com/devforumtxt/status/1398861241284665344)
that tried banning a whole timezone while I was developing this.

## Implementation

For the purpose of explanation the term **session** will refer to the time the
CPU is running up until restart.

Credit to [mpeterv's sha1 module](https://github.com/mpeterv/sha1) which was
modified for use in Roblox.

1. Obtain some data points on the device. For this implementation the following
   data points are used. **It is important the CPU Start is used**.

   - CPU Start: `tick() - os.clock()`
   - Timezone: `os.date("%Z")`
   - Is Daylight Savings Time: `os.date("*t").isdst`
   - Has Accelerometer: `UserInputService.AccelerometerEnabled`
   - Has Touchscreen: `UserInputService.TouchEnabled`

2. Organize the data points in a table, the structure of the table does not
   matter as long as it is consistent.

3. Convert the table to a string, any method that can convert a table to a
   string is acceptable. Easiest would be JSON encoding as Roblox provides
   `HttpService:JSONEncode()`.

4. This step is optional but is used for easier storage of the data points.
   Hash the string using any algorithm. This demonstration uses a SHA1 hash.

## Demonstration

1. Using Rojo sync in the project
2. Playtest and check output for fingerprint hash
3. Logout and test on another account, both accounts should have the same hash
4. Restart the computer
5. Repeat steps 2 & 3. A new hash will be generated for the session.

## Proposed Solution

A simple fix for this would be to have `os.clock()` return the time since the
Roblox client started rather than the CPU.

## Potential

Experimented only on a small-scale with a handful of accounts the hashes and
user IDs of players can be linked together in a database where any user ID or
any hash when queried could return all associated user IDs and hashes.

If employed on a large game the people able to access the database would be able
to track players across multiple accounts even if no wrongdoing occurred. This
would be a a blantant violation of privacy.

This would only be the beginning of such a scenario. As many Roblox users also
use Discord and often these Discord servers use bots which verify users by
linking their Roblox account to their Discord. This now opens the possibility of
finding all of a Discord user's Roblox accounts or vise versa. This would even
allow for somebody to potentially query Steam, Twitter, Twitch, Spotify
accounts, etc. as Discord allows users to link those accounts as well.
