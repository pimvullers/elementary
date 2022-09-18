# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit gnome2 meson vala

DESCRIPTION="Stylish top panel that holds indicators and spawns an application launcher"
HOMEPAGE="https://github.com/elementary/wingpanel"
SRC_URI="https://github.com/elementary/wingpanel/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE="example"

RDEPEND="
	>=dev-libs/glib-2.40:2
	dev-libs/libgee:0.8
	dev-libs/granite:0
	>=x11-libs/gtk+-3.22:3
	x11-wm/gala
	>=x11-wm/mutter-3.27:=
"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig
"

src_prepare() {
	eapply ${FILESDIR}/434.patch
	eapply ${FILESDIR}/435.patch
	eapply ${FILESDIR}/453.patch

	eapply_user
	vala_src_prepare
}

src_configure() {
	local emesonargs=(
		-Dexample=$(usex example true false)
	)
	meson_src_configure
}
