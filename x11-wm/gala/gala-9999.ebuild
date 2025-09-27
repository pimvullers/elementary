# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

VALA_MIN_API_VERSION=0.28

inherit gnome2 systemd meson vala git-r3

DESCRIPTION="Pantheon's Window Manager"
HOMEPAGE="https://github.com/elementary/gala"
EGIT_REPO_URI="https://github.com/elementary/gala.git"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="systemd"

VALA_USE_DEPEND="vapigen"

RDEPEND="
	media-libs/libcanberra
	dev-libs/glib:2
	dev-libs/granite:7
	dev-libs/libgee:0.8
	dev-db/sqlite:3
	gnome-base/gnome-desktop:3
	gui-libs/gtk:4
	x11-wm/mutter[wayland]
	systemd? ( sys-apps/systemd )
	x11-libs/gtk+:3
	gui-libs/libhandy:1
"

DEPEND="${RDEPEND}
	$(vala_depend)
	dev-util/wayland-scanner
	virtual/pkgconfig
"

src_prepare() {
	eapply_user
	vala_setup

	sed -i -e "s#'vapigen'#'${VAPIGEN}'#" meson.build
	sed -i -e "s#pid_t#int#" vapi/libmutter.vapi lib/App.vala src/WindowTracker.vala
}

src_configure() {
	local emesonargs=(
		-Dsystemd=$(usex systemd true false)
		-Dsystemduserunitdir=$(usex systemd $(systemd_get_userunitdir) no)
	)
	meson_src_configure
}
