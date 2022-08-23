#!/bin/sh
dpkg-query --show --showformat '# ${binary:Package}@${source:Upstream-Version}(${Version})\n*/${source:Package}@${source:Upstream-Version}\n' > deb.provided
