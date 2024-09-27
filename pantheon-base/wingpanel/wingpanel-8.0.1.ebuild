# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit gnome2 meson vala

DESCRIPTION="Stylish top panel that holds indicators and spawns an application launcher"
HOMEPAGE="https://github.com/elementary/wingpanel"
SRC_URI="https://github.com/elementary/wingpanel/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE="examples"

RDEPEND="
	dev-libs/glib:2
	dev-libs/libgee:0.8
	dev-libs/granite:0
	dev-libs/wayland
	x11-libs/gtk+:3
	x11-libs/libX11
	x11-wm/gala
	x11-wm/mutter
"
DEPEND="${RDEPEND}
	$(vala_depend)
	dev-util/wayland-scanner
	virtual/pkgconfig
"

src_prepare() {
	eapply_user
	eapply "${FILESDIR}/${PN}-8.0.0_mutter45.patch"
	vala_setup
}

src_configure() {
	local emesonargs=(
		-Dexample=$(usex examples true false)
	)
	meson_src_configure
}
