# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit gnome2-utils meson vala xdg-utils

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
	eapply ${FILESDIR}/435.diff

	eapply_user
	vala_src_prepare
}

src_configure() {
	local emesonargs=(
		-Dexample=$(usex example true false)
	)
	meson_src_configure
}

pkg_preinst() {
	gnome2_schemas_savelist
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
	gnome2_schemas_update
}
