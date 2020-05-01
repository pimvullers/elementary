# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

VALA_MIN_API_VERSION=0.22

inherit gnome2-utils meson vala xdg-utils

DESCRIPTION="Modular desktop settings hub"
HOMEPAGE="https://github.com/elementary/switchboard"
SRC_URI="https://github.com/elementary/switchboard/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE="nls example"

RDEPEND="
	>=dev-libs/glib-2.32:2
	dev-libs/granite
	dev-libs/libgee:0.8
	media-libs/clutter-gtk
	>=x11-libs/gtk+-3.10:3
"
DEPEND="${RDEPEND}
	$(vala_depend)
	nls? ( sys-devel/gettext )
	virtual/pkgconfig
"

src_prepare() {
	eapply_user
	vala_src_prepare
}

src_configure() {
	local emesonargs=(
		-Dexample=$(usex example true false)
		-Dlibunity=false
	)
	meson_src_configure
}

pkg_preinst() {
	gnome2_schemas_savelist
}

pkg_postinst() {
	gnome2_schemas_update
	xdg_desktop_database_update
}

pkg_postrm() {
	gnome2_schemas_update
	xdg_desktop_database_update
}
