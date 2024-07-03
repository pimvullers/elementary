# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

VALA_MIN_API_VERSION=0.22

inherit gnome2 meson vala xdg

DESCRIPTION="Modular desktop settings hub"
HOMEPAGE="https://github.com/elementary/switchboard"
SRC_URI="https://github.com/elementary/switchboard/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="2"
KEYWORDS="amd64"
IUSE="examples"

RDEPEND="
	>=dev-libs/glib-2.32:2
	dev-libs/granite:0
	dev-libs/libgee:0.8
	media-libs/clutter-gtk
	>=x11-libs/gtk+-3.10:3
	!pantheon-base/switchboard:0
"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig
"

src_prepare() {
	eapply_user
	vala_setup
}

src_configure() {
	local emesonargs=(
		-Dexample=$(usex examples true false)
	)
	meson_src_configure
}
