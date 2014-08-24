# Makefile for this awesome project
#
# Targets:
#
#     make run    # Test game on default platform
#

# Change to `flash`, `neko`, `linux`, `windows`...
PLATFORM = neko

run:
	lime test neko -debug

