# OpenJazz makefile
prefix=/usr/local

objects = \
	src/game/clientgame.o src/game/game.o src/game/gamemode.o \
	src/game/localgame.o src/game/servergame.o \
	src/io/gfx/anim.o src/io/gfx/font.o src/io/gfx/paletteeffects.o \
	src/io/gfx/sprite.o src/io/gfx/video.o \
	src/io/gfx/scale2x/getopt.o src/io/gfx/scale2x/pixel.o \
	src/io/gfx/scale2x/scale2x.o src/io/gfx/scale2x/scale3x.o \
	src/io/gfx/scale2x/scalebit.o src/io/gfx/scale2x/simple2x.o \
	src/io/controls.o src/io/file.o src/io/network.o src/io/sound.o \
	src/jj1bonuslevel/jj1bonuslevelplayer/jj1bonuslevelplayer.o \
	src/jj1bonuslevel/jj1bonuslevel.o \
	src/jj1level/jj1event/jj1bridge.o src/jj1level/jj1event/jj1event.o \
	src/jj1level/jj1event/jj1guardians.o \
	src/jj1level/jj1event/jj1standardevent.o \
	src/jj1level/jj1levelplayer/jj1bird.o \
	src/jj1level/jj1levelplayer/jj1levelplayer.o \
	src/jj1level/jj1levelplayer/jj1levelplayerframe.o \
	src/jj1level/jj1bullet.o src/jj1level/jj1demolevel.o \
	src/jj1level/jj1level.o src/jj1level/jj1levelframe.o \
	src/jj1level/jj1levelload.o \
	src/jj1planet/jj1planet.o \
	src/jj1scene/jj1scene.o src/jj1scene/jj1sceneload.o \
	src/jj2level/jj2event/jj2event.o src/jj2level/jj2event/jj2eventframe.o \
	src/jj2level/jj2levelplayer/jj2levelplayer.o \
	src/jj2level/jj2levelplayer/jj2levelplayerframe.o \
	src/jj2level/jj2layer.o src/jj2level/jj2level.o \
	src/jj2level/jj2levelframe.o src/jj2level/jj2levelload.o \
	src/level/level.o src/level/movable.o src/level/levelplayer.o \
	src/menu/gamemenu.o src/menu/mainmenu.o src/menu/menu.o \
	src/menu/plasma.o src/menu/setupmenu.o \
	src/player/player.o \
	src/main.o src/setup.o src/util.o

CXXFLAGS += -g -Wall -O2 -DSCALE
CXXFLAGS += -DUSE_SOCKETS

# SDL flags
CXXFLAGS+=`sdl-config --cflags`
LDFLAGS+=`sdl-config --libs`

# Enable modplug music
CXXFLAGS += -DUSE_MODPLUG `pkg-config --cflags libmodplug`
LDFLAGS += `pkg-config --libs libmodplug`

OpenJazz: $(objects)
	cc $(CXXFLAGS) -o OpenJazz $(LDFLAGS) -lstdc++ -lz $(objects)

%.o: %.cpp
	cc $(CXXFLAGS) -Isrc -c $< -o $@

clean:
	rm -f OpenJazz $(objects)

install: OpenJazz
	install -m 0755 OpenJazz $(prefix)/bin
	install -m 0644 openjazz.000 $(prefix)/bin

.PHONY: install
