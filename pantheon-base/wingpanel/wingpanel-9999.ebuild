# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit gnome2 meson vala git-r3

DESCRIPTION="Stylish top panel that holds indicators and spawns an application launcher"
HOMEPAGE="https://github.com/elementary/wingpanel"
EGIT_REPO_URI="https://github.com/elementary/wingpanel.git"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="examples"

RDEPEND="
	dev-libs/glib:2
	dev-libs/libgee:0.8
	dev-libs/granite:0
	dev-libs/wayland
	x11-libs/gtk+:3
	x11-libs/libX11
	x11-wm/gala
"
DEPEND="${RDEPEND}
	$(vala_depend)
	dev-util/wayland-scanner
	virtual/pkgconfig
"

src_prepare() {
	eapply_user
	vala_setup
	sed -i -e "s/wm.push_modal (stage)/wm.push_modal (stage,true)/" wingpanel-interface/FocusManager.vala
}

src_configure() {
	local emesonargs=(
		-Dexample=$(usex examples true false)
	)
	meson_src_configure
}
